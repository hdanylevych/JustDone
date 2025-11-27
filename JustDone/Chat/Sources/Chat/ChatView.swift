//
//  SwiftUIView.swift
//  Chat
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core

public struct ChatView: View {
    @Environment(Router.self) var router
    
    @State var vm: ChatVM
    
    public init(model: ChatModel) {
        _vm = State(initialValue: ChatVM(model: model))
    }
    
    public var body: some View {
        content
            .onAppear {
                vm.setRouter(router)
            }
    }
    
    var content: some View {
        Text("Hello CHAT!")
    }
}

#Preview {
    ChatView(model: ChatModel(id: "1"))
        .environment(Router())
}
