//
//  ChatModel.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Foundation

public struct ChatModel: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let title: String
    
    public init(id: UUID, title: String) {
        self.id = id
        self.title = title
    }
}
