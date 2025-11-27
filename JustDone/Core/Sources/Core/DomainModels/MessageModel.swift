//
//  MessageModel.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Foundation

public struct MessageModel: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let text: String
    public let createdAt: Date
    public let isIncoming: Bool
    
    public init(id: UUID, text: String, createdAt: Date, isIncoming: Bool) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.isIncoming = isIncoming
    }
}
