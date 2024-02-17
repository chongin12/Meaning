//
//  File.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

final class TokenStorage: ObservableObject {
    @Published var words: [TokenGroup]
    @Published var phrases: [TokenGroup]
    @Published var sentences: [TokenGroup]
    init(words: [TokenGroup] = [], phrases: [TokenGroup] = [], sentences: [TokenGroup] = []) {
        self.words = words
        self.phrases = phrases
        self.sentences = sentences
    }
    static let mockData = TokenStorage(
        words: [
            TokenGroup(colorTheme: .mint, tokens: [TokenModel("first")]),
            TokenGroup(colorTheme: .peach, tokens: [TokenModel("second", colorTheme: .peach)]),
        ],
        phrases: [
            TokenGroup(
                colorTheme: .skyblue,
                tokens: [TokenModel("first on phrases", colorTheme: .ravender)]
            ),
            TokenGroup(
                colorTheme: .skyblue,
                tokens: [TokenModel("second on phrases", colorTheme: .ravender)]
            )
        ],
        sentences: [
            TokenGroup(tokens: [
                TokenModel("first on sentences", colorTheme: .ravender),
                TokenModel("another", colorTheme: .turquoise),
                TokenModel("elements.", colorTheme: .skyblue),
            ]),
            TokenGroup(tokens: [
                TokenModel("second on sentences", colorTheme: .ravender),
                TokenModel("on me", colorTheme: .vanilla),
                TokenModel("asdfasdfasdfasdf.", colorTheme: .pink),
            ]),
            TokenGroup(tokens: [
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
                TokenModel("I", colorTheme: .ravender),
                TokenModel("have", colorTheme: .vanilla),
                TokenModel("too", colorTheme: .pink),
                TokenModel("many", colorTheme: .ravender),
                TokenModel("components", colorTheme: .vanilla),
                TokenModel("hahaha!", colorTheme: .pink),
            ])
        ]
    )
    public func find(by ID: String) -> TokenGroup {
        let filteredWords = words.filter {
            $0.id == ID
        }
        if !filteredWords.isEmpty {
            return filteredWords[0]
        }

        let filteredPhrases = phrases.filter {
            $0.id == ID
        }
        if !filteredPhrases.isEmpty {
            return filteredPhrases[0]
        }

        let filteredSentences = sentences.filter {
            $0.id == ID
        }
        if !filteredSentences.isEmpty {
            return filteredSentences[0]
        }

        return .empty
    }
}
