//
//  PermissionsService.swift
//  Utils
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import Speech
import AVFoundation
import Core

@MainActor
public final class PermissionsService: IPermissionsService {
    
    public init() {}
    
    
    public func requestSpeechPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { @Sendable status in
                let allowed = (status == .authorized)
                continuation.resume(returning: allowed)
            }
        }
    }
    
    public func requestMicrophonePermission() async -> Bool {
        return await AVAudioApplication.requestRecordPermission()
    }
}
