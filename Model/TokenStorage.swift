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
    public func findGroup(by ID: String) -> Binding<TokenGroup>? {
        if let wordsIndex = words.firstIndex(where: { tokenGroup in
            tokenGroup.id == ID
        }) {
            return Binding {
                self.words[wordsIndex]
            } set: { value in
                self.words[wordsIndex] = value
            }
        }

        if let phrasesIndex = phrases.firstIndex(where: { tokenGroup in
            tokenGroup.id == ID
        }) {
            return Binding {
                self.phrases[phrasesIndex]
            } set: { value in
                self.phrases[phrasesIndex] = value
            }
        }

        if let sentencesIndex = sentences.firstIndex(where: { tokenGroup in
            tokenGroup.id == ID
        }) {
            return Binding {
                self.sentences[sentencesIndex]
            } set: { value in
                self.sentences[sentencesIndex] = value
            }
        }

        return nil
    }
    public func findToken(groupID: String, tokenID: UUID) -> Binding<TokenModel>? {
        if let group = findGroup(by: groupID) {
            if let index = group.tokens.firstIndex(where: { tokenModel in
                tokenModel.id == tokenID
            }) {
                return group.tokens[index]
            }
        }
        return nil
    }
    public func changeTheme(groupID: String, tokenID: UUID, theme: ColorTheme) {
        if let wordsGroupIndex = words.firstIndex(where: { tokenGroup in
            tokenGroup.id == groupID
        }) {
            if let tokenIndex = words[wordsGroupIndex].tokens.firstIndex(where: { token in
                token.id == tokenID
            }) {
                words[wordsGroupIndex].tokens[tokenIndex].colorTheme = theme
            }
        }
    }
    public func updateToken(with token: TokenModel) {
        for i in 0 ..< words.count {
            if words[i].tokens[0].text == token.text {
                words[i].tokens[0].colorTheme = token.colorTheme
                words[i].tokens[0].canvas = token.canvas
            }
        }

        for i in 0 ..< phrases.count {
            if phrases[i].tokens[0].text == token.text {
                phrases[i].tokens[0].colorTheme = token.colorTheme
                phrases[i].tokens[0].canvas = token.canvas
            }
        }

        for i in 0 ..< sentences.count {
            for j in 0 ..< sentences[i].tokens.count {
                if sentences[i].tokens[j].text == token.text {
                    sentences[i].tokens[j].colorTheme = token.colorTheme
                    sentences[i].tokens[j].canvas = token.canvas
                }
            }
        }
    }
}
