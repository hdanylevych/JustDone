//
//  DSIcon.swift
//  DesignSystem
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI

public enum DSIcon: String {
    case camera
}

public extension Image {
    static func dsIcon(_ image: DSIcon) -> Image {
        .init(image.rawValue, bundle: .module)
    }
}
