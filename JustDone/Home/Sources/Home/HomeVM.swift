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
    
    private var router: Router?
    
    public init() { }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
    
    func onAppear() async {
        try? await databaseService.fetchChats()
    }
    
    func goToChat(chat: ChatModel) {
        router?.navigateTo(.chat(chat))
    }
}
