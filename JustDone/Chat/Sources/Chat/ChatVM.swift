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
    @Injected(\.databaseService) private var databaseService
    
    var messages: [MessageModel] = []
    var isAppearing = true
    
    var title: String {
        model.title
    }
    
    private let model: ChatModel
    private var router: Router?
    
    public init(model: ChatModel) {
        self.model = model
    }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
    
    func fetchMessages() async {
        do {
            messages = try await databaseService.fetchMessages(for: model.id)
        } catch {
            print("Error fetching messages: \(error)")
        }
    }
}
