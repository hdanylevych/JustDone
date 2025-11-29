//
//  ISpeechRecognizer.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

public protocol ISpeechRecognizer: AnyObject {
    @MainActor var recognizedText: String { get }
    @MainActor var onFinalTextReady: ((String) -> Void)? { get set }
    
    @MainActor
    func startRecording(languageCode: String) throws
    func stopRecording()
}

