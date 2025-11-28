//
//  UtilsComposition.swift
//  AppDI
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import FactoryKit
import Core
import Utils

public extension Container {
    var speechRecognizer: Factory<ISpeechRecognizer> {
        self { @MainActor in SpeechRecognizer() }
            .singleton
    }
    
    var permissionsService: Factory<IPermissionsService> {
        self { @MainActor in PermissionsService() }
            .singleton
    }
}
