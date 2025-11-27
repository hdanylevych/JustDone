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
    
    var chats: [ChatModel] = []
    
    private var router: Router?
    
    public init() { }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
    
    func onAppear() async {
        do {
            chats = try await databaseService.fetchChats()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func goToChat(chat: ChatModel) {
        router?.navigateTo(.chat(chat))
    }
}
