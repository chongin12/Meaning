//
//  SwiftUIView.swift
//  
//
//  Created by 정종인 on 2/18/24.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
