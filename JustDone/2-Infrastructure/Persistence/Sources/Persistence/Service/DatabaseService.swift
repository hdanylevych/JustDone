//
//  DatabaseService.swift
//  Persistence
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Core
import Foundation

public class DatabaseService: IDatabaseService {
    private let controller = PersistenceController.shared
    
    private var mockChats: [ChatModel] = []
    private var mockMessages: [UUID: [MessageModel]] = [:]
    
    public init() {
        seedMockData()
    }
    
    public func fetchChats() async throws -> [ChatModel] {
        return mockChats
    }
    
    public func fetchMessages(for chatId: UUID) async throws -> [MessageModel] {
        return mockMessages[chatId] ?? []
    }
}

private extension DatabaseService {
    func seedMockData() {
        let chat1 = ChatModel(id: UUID(uuidString: "EFD08840-406D-446F-940D-064040D44400")!, title: "English Tutor")
        let chat2 = ChatModel(id: UUID(), title: "Travel Assistant")
        let chat3 = ChatModel(id: UUID(), title: "Casual Conversation")
        
        mockChats = [chat1, chat2, chat3]
        
        let now = Date()
        func daysAgo(_ d: Int) -> Date { now.addingTimeInterval(TimeInterval(-d * 86400)) }
        
        // MARK: Chat 1 — English Tutor
        mockMessages[chat1.id] = [
            MessageModel(id: UUID(), text: "Hello! Ready for your English lesson today?", createdAt: daysAgo(0).addingTimeInterval(-3600), isIncoming: true),
            MessageModel(id: UUID(), text: "Yes! Let's go.", createdAt: daysAgo(0).addingTimeInterval(-3500), isIncoming: false),
            MessageModel(id: UUID(), text: "Great. Can you write a sentence using the word *although*?", createdAt: daysAgo(0).addingTimeInterval(-3400), isIncoming: true),
            MessageModel(id: UUID(), text: "Although I was tired, I still finished my work.", createdAt: daysAgo(0).addingTimeInterval(-3300), isIncoming: false),
            MessageModel(id: UUID(), text: "Perfect! Very natural phrasing.", createdAt: daysAgo(0).addingTimeInterval(-3200), isIncoming: true),
            MessageModel(id: UUID(), text: "Thanks! Can we practice speaking next time?", createdAt: daysAgo(0).addingTimeInterval(-3100), isIncoming: false),
            MessageModel(id: UUID(), text: "Absolutely. Also try to write 3 short paragraphs about your day.", createdAt: daysAgo(0).addingTimeInterval(-3000), isIncoming: true),
            MessageModel(id: UUID(), text: "Sure, here is the first: I woke up early today because I had a meeting. I prepared coffee and checked my email.", createdAt: daysAgo(0).addingTimeInterval(-2900), isIncoming: false),
            MessageModel(id: UUID(), text: "Nice summary!", createdAt: daysAgo(0).addingTimeInterval(-2800), isIncoming: true),
            
            // More examples
            MessageModel(id: UUID(), text: "Try using past perfect in another example.", createdAt: daysAgo(1).addingTimeInterval(-2000), isIncoming: true),
            MessageModel(id: UUID(), text: "I had already eaten when you called me.", createdAt: daysAgo(1).addingTimeInterval(-1900), isIncoming: false),
            MessageModel(id: UUID(), text: "Correct 👍", createdAt: daysAgo(1).addingTimeInterval(-1850), isIncoming: true),
            MessageModel(id: UUID(), text: "What about conditionals? Can we try type 2?", createdAt: daysAgo(1).addingTimeInterval(-1800), isIncoming: false),
            MessageModel(id: UUID(), text: "Sure: *If I had more free time, I would travel the world.*", createdAt: daysAgo(1).addingTimeInterval(-1750), isIncoming: true),
            MessageModel(id: UUID(), text: "Makes sense!", createdAt: daysAgo(1).addingTimeInterval(-1700), isIncoming: false),
            MessageModel(id: UUID(), text: "Can you rewrite it with a different meaning?", createdAt: daysAgo(1).addingTimeInterval(-1650), isIncoming: true),
            MessageModel(id: UUID(), text: "If I were taller, I would play basketball.", createdAt: daysAgo(1).addingTimeInterval(-1600), isIncoming: false),
            
            // extra filler
            MessageModel(id: UUID(), text: "Good job! See you tomorrow.", createdAt: daysAgo(1).addingTimeInterval(-1500), isIncoming: true)
        ]
        
        // MARK: Chat 2 — Travel Assistant
        mockMessages[chat2.id] = [
            MessageModel(id: UUID(), text: "Where do you want to travel next?", createdAt: daysAgo(3).addingTimeInterval(-5000), isIncoming: true),
            MessageModel(id: UUID(), text: "Japan! I always wanted to visit Tokyo.", createdAt: daysAgo(3).addingTimeInterval(-4900), isIncoming: false),
            MessageModel(id: UUID(), text: "Tokyo is amazing. Do you prefer modern areas or traditional temples?", createdAt: daysAgo(3).addingTimeInterval(-4800), isIncoming: true),
            MessageModel(id: UUID(), text: "Both! I’d like a mix.", createdAt: daysAgo(3).addingTimeInterval(-4700), isIncoming: false),
            MessageModel(id: UUID(), text: "Then I recommend: Shibuya, Akihabara, Asakusa, and Meiji Shrine.", createdAt: daysAgo(3).addingTimeInterval(-4600), isIncoming: true),
            MessageModel(id: UUID(), text: "Sounds perfect! What about food?", createdAt: daysAgo(3).addingTimeInterval(-4500), isIncoming: false),
            MessageModel(id: UUID(), text: "Try ramen, omurice, yakitori, and obviously sushi 🍣", createdAt: daysAgo(3).addingTimeInterval(-4400), isIncoming: true),
            
            // More chat history
            MessageModel(id: UUID(), text: "Should I get a Japan Rail Pass?", createdAt: daysAgo(4).addingTimeInterval(-4000), isIncoming: false),
            MessageModel(id: UUID(), text: "If you travel between cities (Tokyo ↔ Osaka), yes. It saves money.", createdAt: daysAgo(4).addingTimeInterval(-3950), isIncoming: true),
            MessageModel(id: UUID(), text: "What city is best after Tokyo?", createdAt: daysAgo(4).addingTimeInterval(-3900), isIncoming: false),
            MessageModel(id: UUID(), text: "Kyoto for temples, Osaka for food.", createdAt: daysAgo(4).addingTimeInterval(-3800), isIncoming: true),
            
            MessageModel(id: UUID(), text: "Thanks! I'll plan it out.", createdAt: daysAgo(4).addingTimeInterval(-3700), isIncoming: false),
            MessageModel(id: UUID(), text: "Let me know if you want a 5-day itinerary.", createdAt: daysAgo(4).addingTimeInterval(-3600), isIncoming: true)
        ]
        
        // MARK: Chat 3 — Casual Conversation
        mockMessages[chat3.id] = [
            MessageModel(id: UUID(), text: "Hey, what’s up?", createdAt: daysAgo(5).addingTimeInterval(-7000), isIncoming: true),
            MessageModel(id: UUID(), text: "Not much, just working on a project.", createdAt: daysAgo(5).addingTimeInterval(-6900), isIncoming: false),
            MessageModel(id: UUID(), text: "Nice! What kind of project?", createdAt: daysAgo(5).addingTimeInterval(-6800), isIncoming: true),
            MessageModel(id: UUID(), text: "An AI chat-based app actually.", createdAt: daysAgo(5).addingTimeInterval(-6700), isIncoming: false),
            MessageModel(id: UUID(), text: "Oh! Sounds cool. How’s it going?", createdAt: daysAgo(5).addingTimeInterval(-6600), isIncoming: true),
            MessageModel(id: UUID(), text: "Pretty good, making progress every day.", createdAt: daysAgo(5).addingTimeInterval(-6500), isIncoming: false),
            
            // More conversation
            MessageModel(id: UUID(), text: "Are you planning to add voice input?", createdAt: daysAgo(6).addingTimeInterval(-6000), isIncoming: true),
            MessageModel(id: UUID(), text: "Yep, voice and maybe a tutor mode.", createdAt: daysAgo(6).addingTimeInterval(-5900), isIncoming: false),
            MessageModel(id: UUID(), text: "That would be awesome. Keep going!", createdAt: daysAgo(6).addingTimeInterval(-5800), isIncoming: true),
            
            // Filler
            MessageModel(id: UUID(), text: "Thanks!", createdAt: daysAgo(6).addingTimeInterval(-5700), isIncoming: false),
            MessageModel(id: UUID(), text: "Any weekend plans?", createdAt: daysAgo(6).addingTimeInterval(-5600), isIncoming: true),
            MessageModel(id: UUID(), text: "Probably rest and play guitar.", createdAt: daysAgo(6).addingTimeInterval(-5500), isIncoming: false),
            MessageModel(id: UUID(), text: "Nice 🎸 enjoy!", createdAt: daysAgo(6).addingTimeInterval(-5400), isIncoming: true)
        ]
    }
}
