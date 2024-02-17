//
//  TokenGroupView.swift
//
//
//  Created by 정종인 on 2/17/24.
//

import SwiftUI
import WrappingHStack

struct TokenGroupView: View {
    var tokenGroupID: String
    @EnvironmentObject var tokenStorage: TokenStorage
    var currentTokenGroup: TokenGroup {
        tokenStorage.find(by: tokenGroupID)
    }
    init(_ tokenGroupID: String) {
        self.tokenGroupID = tokenGroupID
    }
    var body: some View {
        ScrollView {
            WrappingHStack(currentTokenGroup.tokens, alignment: .leading, spacing: .constant(25.0), lineSpacing: 50.0) { token in
                TokenView(token: token)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NavigationStack {
        TokenGroupView(TokenStorage.mockData.sentences[2].id)
            .environmentObject(TokenStorage.mockData)
    }
}
