//
//  HomeVM.swift
//  Home
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import FactoryKit
import InfrastructureDI
import Core

@MainActor
@Observable
public class HomeVM {
    @ObservationIgnored
    @Injected(\.databaseService) private var databaseService
    
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
    }
    
    func goToChat(chat: ChatModel) {
        router?.navigateTo(.chat(chat))
    }
    
    func newChatTapped() {
        let model = ChatModel(id: UUID(), title: "New Chat")
        router?.navigateTo(.chat(model))
    }
}
