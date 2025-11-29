//
//  IPermissionsService.swift
//  Core
//
//  Created by Hnat Danylevych on 27.11.2025.
//

@MainActor
public protocol IPermissionsService: Sendable {
    func requestSpeechPermission() async -> Bool
    func requestMicrophonePermission() async -> Bool
}
