//
//  Container.swift
//  InfrastructureDI
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import FactoryKit
import Core
import Persistence

public extension Container {
    var databaseService: Factory<IDatabaseService> {
        self { @MainActor in DatabaseService() }
            .singleton
    }
}
