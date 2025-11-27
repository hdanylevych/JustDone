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
            .task {
                vm.setRouter(router)
                await vm.onAppear()
            }
    }
    
    var content: some View {
        VStack {
            Text("Hello, Home!")
            
            Button {
                vm.goToChat(chat: ChatModel(id: "1"))
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
}

#Preview {
    HomeView()
        .environment(Router())
}
