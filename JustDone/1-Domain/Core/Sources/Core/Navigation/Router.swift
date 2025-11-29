//
//  Router.swift
//  App
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI

@Observable
@MainActor
public final class Router {
    public var path: [RouterDestination] = []
    
    public var showAlert = false
    public var alert: AlertViewModel = AlertType.noWordsRecognized.vm
    
    public init() { }
    
    public func popToRoot() {
        path = []
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func navigateTo(_ destination: RouterDestination) {
        if path.isEmpty {
            path = [destination]
        } else {
            path.append(destination)
        }
    }
    
    public func presentAlert(_ type: AlertType) {
        alert = type.vm
        showAlert = true
    }
}
