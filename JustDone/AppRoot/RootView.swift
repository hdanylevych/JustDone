//
//  RootView.swift
//  JustDone
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core
import Home
import Chat

struct RootView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        @Bindable var router = router
        
        GeometryReader { _ in
            NavigationStack(path: $router.path) {
                HomeView()
                    .navigationDestination(for: RouterDestination.self) { destination in
                        switch destination {
                        case .chat(let model):
                            ChatView(model: model)
                        }
                    }
            }
            .showAlert(viewModel: router.alert, isPresented: $router.showAlert)
        }
    }
}

#Preview {
    RootView()
}
