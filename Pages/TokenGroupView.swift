//
//  TokenGroupView.swift
//
//
//  Created by 정종인 on 2/17/24.
//

import SwiftUI

struct TokenGroupView: View {
    var tokenGroupID: String
    @EnvironmentObject var tokenStorage: TokenStorage
    var currentTokenGroup: TokenGroup? {
        tokenStorage.find(by: tokenGroupID)
    }
    init(_ tokenGroupID: String) {
        self.tokenGroupID = tokenGroupID
    }
    var body: some View {
        Text("id : \(currentTokenGroup?.id ?? "no currentTokenGroup")")
        Text(currentTokenGroup?.tokens.debugDescription ?? "none!")
    }
}

#Preview {
    TokenGroupView(TokenStorage.mockData.words[0].id)
        .environmentObject(TokenStorage.mockData)
}
