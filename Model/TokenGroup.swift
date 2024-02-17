//
//  File.swift
//  
//
//  Created by 정종인 on 2/17/24.
//

import SwiftUI

struct TokenGroup {
    var text: String {
        self.serializedString
    }
    var colorTheme: ColorTheme?
    var tokens: [TokenModel]
}

extension TokenGroup: Identifiable, Equatable {
    var id: String {
        self.serializedString
    }
}

extension TokenGroup {
    static let mockData = TokenGroup(
        colorTheme: .peach,
        tokens: [.mockData]
    )
}

extension TokenGroup {
    private var serializedString: String {
        self.tokens.reduce("") { partialResult, token in
            partialResult + token.text
        }
    }
}
