//
//  IDatabaseService.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI

@MainActor
public protocol IDatabaseService {
    func fetchChats() async throws -> [ChatModel]
    func fetchMessages(for chatId: UUID) async throws -> [MessageModel]
}
