//
//  MessageModel.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Foundation

public struct MessageModel: Identifiable, Hashable, Sendable {
    public let id: String
    public let text: String
    public let createdAt: Date
    public let isIncoming: Bool
}
