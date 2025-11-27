//
//  ChatVM.swift
//  Chat
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core

@MainActor
@Observable
public class ChatVM {
    private let model: ChatModel
    private var router: Router?
    
    public init(model: ChatModel) {
        self.model = model
    }
    
    func setRouter(_ router: Router) {
        self.router = router
    }
}
