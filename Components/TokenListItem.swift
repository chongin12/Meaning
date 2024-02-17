//
//  SwiftUIView.swift
//  
//
//  Created by 정종인 on 2/16/24.
//

import SwiftUI

struct TokenListItem: View {
    var tokenGroup: TokenGroup
    var body: some View {
        Label {
            Text("\(tokenGroup.text), \(tokenGroup.colorTheme.debugDescription)")
        } icon: {
            if let icon = tokenGroup.colorTheme?.themePreviewImage {
                icon
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
            }
        }
        .frame(maxHeight: 30)
    }
}

#Preview {
    TokenListItem(tokenGroup: .mockData)
}

