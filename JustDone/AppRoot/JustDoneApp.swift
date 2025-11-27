//
//  JustDoneApp.swift
//  JustDone
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core

@main
struct JustDoneApp: App {
    @State private var router = Router()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
        }
    }
}
