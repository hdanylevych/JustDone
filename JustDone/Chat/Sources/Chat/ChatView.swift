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
            .navigationTitle(vm.title)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                vm.setRouter(router)
                await vm.fetchMessages()
            }
    }
    
    var content: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(vm.messages, id: \.self) { message in
                        VStack {
                            MessageView(model: message)
                            
                            if vm.messages.last == message {
                                Spacer()
                                    .frame(height: 70)
                            }
                        }
                        .id(message.id)
                    }
                }
            }
            .onChange(of: vm.messages.count) { _, _ in
                guard let last = vm.messages.last else {
                    print("GUARD FAILED")
                    return }
                
                if vm.isAppearing {
                    vm.isAppearing = false
                    proxy.scrollTo(last, anchor: .bottom)
                    return
                }
                
                withAnimation(.easeInOut(duration: 0.1)) {
                    proxy.scrollTo(last, anchor: .bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MessageView: View {
    let model: MessageModel
    
    var body: some View {
        HStack {
            if model.isIncoming {
                bubble
                Spacer(minLength: 40)
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    private var bubble: some View {
        Text(model.text)
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(model.isIncoming ? Color.purple : Color.blue)
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: model.isIncoming ? .leading : .trailing)
    }
}

#Preview {
    ChatView(
        model: ChatModel(id: UUID(uuidString: "EFD08840-406D-446F-940D-064040D44400")!,
        title: "Testing Chat")
    )
    .environment(Router())
}
