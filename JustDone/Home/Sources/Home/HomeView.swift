//
//  HomeView.swift
//  Home
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core
import DesignSystem

public struct HomeView: View {
    @Environment(Router.self) var router
    
    @State var vm: HomeVM = HomeVM()
    
    public init() { }
    
    public var body: some View {
        
        content
            .navigationTitle(Text("Home"))
            .task {
                vm.setRouter(router)
                await vm.fetchChats()
            }
    }
    
    var content: some View {
        List {
            ForEach(vm.chats) { chat in
                Text(chat.title)
                    .onTapGesture {
                        self.vm.goToChat(chat: chat)
                    }
            }
        }
    }
    
    var createChatBtn: some View {
        Button {
            vm.goToChat(chat: ChatModel(id: UUID(), title: "Testing Chat"))
        } label: {
            Text("Create new Chat")
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .foregroundStyle(.white)
                .background(.blue)
                .cornerRadius(24)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
}
