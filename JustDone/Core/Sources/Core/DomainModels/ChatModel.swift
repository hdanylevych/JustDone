//
//  ChatModel.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

public struct ChatModel: Identifiable, Hashable, Sendable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
