//
//  View.swift
//  Core
//
//  Created by Hnat Danylevych on 28.11.2025.
//

import SwiftUI

public extension View {
    func showAlert(viewModel: AlertViewModel, isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: AlertModifier(viewModel: viewModel, isPresented: isPresented))
    }
}
