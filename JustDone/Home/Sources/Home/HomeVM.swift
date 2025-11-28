//
//  HomeVM.swift
//  Home
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import FactoryKit
import AppDI
import Core

@MainActor
@Observable
public class HomeVM {
    @ObservationIgnored
    @Injected(\.databaseService) private var databaseService
    
    @ObservationIgnored
    @Injected(\.permissionsService) var permissionsService
    
    var chats: [ChatModel] = []
    
    private var router: Router?
    
    public init() { }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
    
    func fetchChats() async {
        do {
            chats = try await databaseService.fetchChats()
        } catch {
            print("Error fetching chats: \(error)")
        }
        
        let speechPermission = await permissionsService.requestSpeechPermission()
        let microphonePermission = await permissionsService.requestMicrophonePermission()
        
        let permissionGranted = speechPermission && microphonePermission
        if !permissionGranted {
            router?.presentAlert(.noSpeechPermission(action: {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            }))
        }
    }
    
    func goToChat(chat: ChatModel) {
        router?.navigateTo(.chat(chat))
    }
}
