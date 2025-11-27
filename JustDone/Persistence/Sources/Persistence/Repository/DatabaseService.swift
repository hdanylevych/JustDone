//
//  DatabaseService.swift
//  Persistence
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Core
import FactoryKit

public class DatabaseService: IDatabaseService {
    private let controller = PersistenceController()
    
    public init() { }
    
    public func fetchChats() async throws -> [ChatModel] {
        return []
    }
    
    public func fetchMessages(for chatId: String) async throws -> [MessageModel] {
        return []
    }
}
