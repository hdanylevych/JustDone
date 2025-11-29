//
//  AlertModifier.swift
//  JustDone
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI

public struct AlertViewModel {
    struct Button: Identifiable {
        enum ButtonType {
            case regular(_ title: String = "OK")
            case cancel(_ title: String = "Cancel")
            case destructive(_ title: String = "Delete")
            case title(_ title: String)
            
            var title: String {
                switch self {
                case let .regular(title): return title
                case let .cancel(title): return title
                case let .destructive(title): return title
                case let .title(title): return title
                }
            }
        }
        
        var id: String = UUID().uuidString
        var title: String { return type.title }
        var type: ButtonType = .regular()
        var action: (() -> Void)?
    }
    
    struct TextField: Identifiable {
        var id: String = UUID().uuidString
        
        @Binding var text: String
    }
    
    var title: String? = nil
    var message: String? = nil
    var textField: TextField? = nil
    var buttons: [Button] = [Button(type: .regular())]
}

public enum AlertType {
    case noSpeechPermission(action: () -> Void)
    case noWordsRecognized
    
    public var vm: AlertViewModel {
        switch self {
        case .noWordsRecognized:
            let okAction = AlertViewModel.Button(type: .regular())
            
            return AlertViewModel(
                title: "No Speech Detected",
                message: "We couldn’t recognize any speech. Try again.",
                buttons: [okAction]
            )
        case .noSpeechPermission(let action):
            let cancel = AlertViewModel.Button(type: .cancel())
            let openSettings = AlertViewModel.Button(type: .regular("Open Settings"), action: action)
            
            return AlertViewModel(
                title: "Speech Recognition Disabled",
                message: "Please enable speech recognition in Settings to use voice input.",
                buttons: [cancel, openSettings]
            )
        }
    }
}

public struct AlertModifier: ViewModifier {
    let viewModel: AlertViewModel
    
    @Binding var isPresented: Bool
    
    public func body(content: Content) -> some View {
        content
            .alert(viewModel.title ?? "", isPresented: $isPresented) {
                if let textField = viewModel.textField {
                    TextField("", text: textField.$text)
                }
                
                ForEach(viewModel.buttons, id:\.id) { button in
                    switch button.type {
                    case .regular:
                        Button(button.title) {
                            button.action?()
                        }
                    case .cancel:
                        Button(button.title, role: .cancel) {
                            button.action?()
                        }
                    case .destructive(let title):
                        Button(title, role: .destructive) {
                            button.action?()
                        }
                    case .title(let title):
                        Button(title) {
                            button.action?()
                        }
                    }
                }
            } message: {
                if viewModel.message != nil {
                    Text(viewModel.message ?? "")
                }
            }
    }
}
