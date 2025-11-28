//
//  SpeechRecognizer.swift
//  JustDone
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Foundation
import AVFoundation
import Speech
import Observation
import Core

@Observable
public final class SpeechRecognizer: ISpeechRecognizer, @unchecked Sendable {
    
    public var recognizedText: String = ""
    public private(set) var isFinal: Bool = false
    
    public var onFinalTextReady: ((String) -> Void)?
    
    private let audioEngine = AVAudioEngine()
    
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    // This will store each segment's recognized text, especially useful if recognition restarts
    private var transcriptSegments: [String] = []
    
    private var newRecognizedText: String = ""
    private var isRunning = false
    private var isTechRestart = false
    
    private var stopTimer: Timer?
    
    private var spaceSeparator: String {
        transcriptSegments.isEmpty ? "" : " "
    }
    
    public init() {}
    
    public func startRecording(languageCode: String) throws {
        // Configure recognizer for given locale
        guard let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: languageCode)) else {
            throw NSError(domain: "SpeechRecognizer", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unsupported language code"])
        }
        self.speechRecognizer = speechRecognizer
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        recognitionTask = nil
        recognizedText = ""
        isFinal = false
        transcriptSegments.removeAll()
        newRecognizedText = ""
        
        // Create recognition request
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest.shouldReportPartialResults = false
        recognitionRequest.addsPunctuation = true
        self.recognitionRequest = recognitionRequest
        
        let inputNode = audioEngine.inputNode
        
        // Configure task callback
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] (result, error) in
            // Hop back to main actor because this closure can be called on a background queue
            Task { @MainActor [weak self] in
                guard let self else { return }
                
                var isFinalResult = false
                
                if let result {
                    self.newRecognizedText = result.bestTranscription.formattedString
                    self.recognizedText = self.transcriptSegments.joined(separator: " ") +
                    "\(self.spaceSeparator)" +
                    self.newRecognizedText
                    isFinalResult = result.isFinal
                    self.isFinal = isFinalResult
                }
                
                if error != nil || isFinalResult {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recognitionTask = nil
                    
                    if isFinalResult && self.isRunning {
                        // technical restart: store the piece and restart recognition
                        self.isTechRestart = true
                        
                        self.stopRecording()
                        do {
                            try self.startRecording(languageCode: languageCode)
                        } catch {
                            // You might want to surface this error
                            print("Failed to restart recording: \(error)")
                        }
                        return
                    } else if isFinalResult {
                        self.stopTimer?.invalidate()
                        self.recognitionTask?.cancel()
                        self.onFinalTextReady?(self.recognizedText)
                        self.transcriptSegments = []
                    } else if let error {
                        print(error.localizedDescription)
                    }
                } else {
                    guard
                        let text = result?.bestTranscription.formattedString,
                        !text.isEmpty
                    else {
                        return
                    }
                    
                    self.recognizedText = self.transcriptSegments.joined(separator: " ") +
                    " " +
                    self.newRecognizedText
                }
            }
        }
        
        // Audio engine
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        if recordingFormat.sampleRate > 0 {
            inputNode.removeTap(onBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { @Sendable [weak self] buffer, _ in
                self?.recognitionRequest?.append(buffer)
            }
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error: \(error)")
            throw error
        }
        
        isRunning = true
    }
    
    public func stopRecording() {
        if isTechRestart {
            isTechRestart = false
            transcriptSegments.append(newRecognizedText)
        }
        
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionRequest?.endAudio()
        }
        
        isRunning = false
        
        stopTimer?.invalidate()
        stopTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
            self?.forceStop()
        }
    }
    
    // MARK: - Private
    
    private func forceStop() {
        recognitionTask?.cancel()
        Task { @MainActor in
            onFinalTextReady?(recognizedText)
        }
    }
}
