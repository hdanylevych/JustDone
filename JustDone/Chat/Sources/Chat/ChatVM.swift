//
//  ChatVM.swift
//  Chat
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import FactoryKit
import AppDI
import Core

@MainActor
@Observable
public class ChatVM {
    @ObservationIgnored
    @Injected(\.speechRecognizer) var speechRecognizer
    
    @ObservationIgnored
    @Injected(\.permissionsService) var permissionsService
    
    @ObservationIgnored
    @Injected(\.databaseService) private var databaseService
    
    var messages: [MessageModel] = []
    var isAppearing = true
    
    var liveTranscription: String {
        speechRecognizer.recognizedText
    }
    var title: String {
        model.title
    }
    
    var isRecording = false
    
    private var permissionGranted = false
    
    private let model: ChatModel
    private var router: Router?
    
    public init(model: ChatModel) {
        self.model = model
        
        speechRecognizer.onFinalTextReady = handleFinalSpeechResult(_:)
    }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
    
    func onAppear() async {
        do {
            messages = try await databaseService.fetchMessages(for: model.id)
        } catch {
            print("Error fetching messages: \(error)")
        }
        
        let speechPermission = await permissionsService.requestSpeechPermission()
        let microphonePermission = await permissionsService.requestMicrophonePermission()
        
        permissionGranted = speechPermission && microphonePermission
        
        if !permissionGranted {
            router?.presentAlert(.noSpeechPermission(action: { [weak self] in
                self?.openSettings()
            }))
        }
    }
    
    func startTapped() {
        guard permissionGranted else {
            router?.presentAlert(.noSpeechPermission(action: { [weak self] in
                self?.openSettings()
            }))
            
            return
        }
        
        do {
            try speechRecognizer.startRecording(languageCode: "en")
            isRecording = true
        } catch {
            speechRecognizer.stopRecording()
            print("Failed to start speech recognition: \(error)")
        }
    }
    
    func stopTapped() {
        isRecording = false
        speechRecognizer.stopRecording()
    }
    
    func handleFinalSpeechResult(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            router?.presentAlert(.noWordsRecognized)
            return
        }
        
        let isIncoming = messages.count % 2 == 0
        let model = MessageModel(
            id: UUID(),
            text: text,
            createdAt: Date(),
            isIncoming: isIncoming
        )
        
        messages.append(model)
    }
    
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
