//
//  MessageView.swift
//  Chat
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import SwiftUI
import Core

struct MessageView: View {
    let model: MessageModel
    
    var body: some View {
        HStack {
            if model.isIncoming {
                bubble
                Spacer(minLength: 40)
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    private var bubble: some View {
        Text(model.text)
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(model.isIncoming ? Color.purple : Color.blue)
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: model.isIncoming ? .leading : .trailing)
    }
}
