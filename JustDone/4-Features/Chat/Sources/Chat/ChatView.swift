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
                recordButtonOverlay
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
                                    .frame(height: 88)
                            }
                        }
                        .id(message.id)
                    }
                }
            }
            .onChange(of: vm.messages.count) { _, _ in
                guard let last = vm.messages.last else { return }
                
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
    
    var recordButtonOverlay: some View {
        VStack(spacing: 0) {
            Spacer()
            
            if vm.isRecording && !vm.liveTranscription.isEmpty {
                VStack(alignment: .leading) {
                    Text(vm.liveTranscription)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(24)
                .padding(.horizontal, 16)
            }
            
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
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                .frame(width: 80, height: 80)
                .background(vm.isRecording ? .red : .blue)
                .clipShape(Circle())
                .shadow(color: vm.isRecording ? .red : .blue, radius: 6)
            }
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
