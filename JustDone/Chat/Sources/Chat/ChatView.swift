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
            .onAppear {
                vm.setRouter(router)
            }
            .task {
                await vm.onAppear()
            }
    }
    
    var content: some View {
        messageCollection
            .overlay {
                VStack(spacing: 0) {
                    Spacer()
                    
                    Button {
                        if vm.isRecording {
                            vm.stopTapped()
                        } else {
                            vm.startTapped()
                        }
                    } label: {
                        VStack {
                            Image(systemName: vm.isRecording ? "stop.fill" : "mic.fill")
                                .frame(width: 64, height: 64)
                                .foregroundColor(.white)
                        }
                        .frame(width: 64, height: 64)
                        .background(vm.isRecording ? .red : .blue)
                        .clipShape(Circle())
                    }
                }
            }
    }
    
    var messageCollection: some View {
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

#Preview {
    ChatView(
        model: ChatModel(id: UUID(uuidString: "EFD08840-406D-446F-940D-064040D44400")!,
        title: "Testing Chat")
    )
    .environment(Router())
}
