//
//  SplitView.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

struct SplitView: View {
    @State private var selection: TokenGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @EnvironmentObject var tokenStorage: TokenStorage
    @Environment(\.showType) var showType

    // MARK: Add Items
    @State private var text: String = ""
    @State private var addingWordItem: Bool = false
    @State private var addingPhraseItem: Bool = false
    @State private var addingSentence: Bool = false

    @State private var choosedTokens: [TokenModel] = []

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                wordsSection()
                Divider()
                phrasessSection()
                Divider()
                sentencesSection()
            }
        } detail: {
            Group {
                if let selection {
                    TokenGroupView(selection.id, $columnVisibility)
                } else {
                    Text("choose any Words, Phrases, or Sentences in Sidebar")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Picker("asdf", selection: showType) {
                        Image(systemName: "rectangle")
                            .tag(ShowType.text)
                        Image(systemName: "rectangle.tophalf.inset.filled")
                            .tag(ShowType.text_picture)
                        Image(systemName: "rectangle.fill")
                            .tag(ShowType.picture)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.brown)
    }

    private func wordsSection() -> some View {
        Section("Words") {
            tokenListItems(tokenGroups: tokenStorage.words)
            addWordItemView()
        }
        .deleteDisabled(false)
    }

    private func phrasessSection() -> some View {
        Section("Phrases") {
            tokenListItems(tokenGroups: tokenStorage.phrases)
            addPhraseItemView()
        }
    }

    private func sentencesSection() -> some View {
        Section("Sentences") {
            tokenListItems(tokenGroups: tokenStorage.sentences)
            addSentenceView()
        }
    }

    @ViewBuilder
    private func addWordItemView() -> some View {
        Button(action: {
            addingWordItem.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .alert("Add Word", isPresented: $addingWordItem) {
            TextField("Enter any word", text: $text)
            Button("OK") {
                if text.trimmingCharacters(in: [" "]) != "" {
                    tokenStorage.words.append(TokenGroup(tokens: [TokenModel(text)]))
                }
                text = ""
            }
            Button("Cancel", role: .cancel, action: {
                text = ""
            })
        }
    }

    @ViewBuilder
    private func addPhraseItemView() -> some View {
        Button(action: {
            addingPhraseItem.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .alert("Add Phrase", isPresented: $addingPhraseItem) {
            TextField("Enter any phrase", text: $text)
            Button("OK") {
                if text.trimmingCharacters(in: [" "]) != "" {
                    tokenStorage.phrases.append(TokenGroup(tokens: [TokenModel(text)]))
                }
                text = ""
            }
            Button("Cancel", role: .cancel, action: {
                text = ""
            })
        }
    }

    @ViewBuilder
    private func addSentenceView() -> some View {
        Button(action: {
            addingSentence.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .sheet(isPresented: $addingSentence, content: {
            NavigationStack {
                HStack {
                    List {
                        Section(header: Text("Words")) {
                            ForEach(tokenStorage.words) { word in
                                Button(word.text) {
                                    withAnimation {
                                        choosedTokens.append(
                                            TokenModel(
                                                word.tokens[0].text,
                                                colorTheme: word.tokens[0].colorTheme,
                                                canvas: word.tokens[0].canvas
                                            )
                                        )
                                    }
                                }
                            }
                        }
                        Section(header: Text("Phrases")) {
                            ForEach(tokenStorage.phrases) { phrase in
                                Button(phrase.text) {
                                    withAnimation {
                                        choosedTokens.append(
                                            TokenModel(
                                                phrase.tokens[0].text,
                                                colorTheme: phrase.tokens[0].colorTheme,
                                                canvas: phrase.tokens[0].canvas
                                            )
                                        )
                                    }
                                }
                            }
                        }
                    }
                    if choosedTokens.isEmpty {
                        VStack {
                            Text("Select words or phrases")
                                .padding(.top)

                            List(choosedTokens) { token in
                                Text(token.text)
                            }
                        }
                    } else {
                        List(choosedTokens) { token in
                            Text(token.text)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            addingSentence.toggle()
                            choosedTokens.removeAll()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            tokenStorage.sentences.append(TokenGroup(tokens: choosedTokens))
                            choosedTokens.removeAll()
                            addingSentence.toggle()
                        }, label: {
                            Text("Done")
                        })
                    }
                }
                .navigationTitle("Add Sentence")
            }
        })
    }

    @ViewBuilder
    private func tokenListItems(tokenGroups : [TokenGroup]) -> some View {
        ForEach(tokenGroups) { tokenGroup in
            HStack {
                Button(action: {
                    withAnimation {
                        selection = tokenGroup
                    }
                }, label: {
                    TokenListItem(tokenGroup: tokenGroup)
                })
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(self.selection == tokenGroup ? Colors.point : Color.clear, in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .foregroundStyle(self.selection == tokenGroup ? Colors.textBright : Color.primary)
            .padding(.vertical, -6.3)
        }
    }
}

#Preview {
    SplitView()
        .environmentObject(TokenStorage.mockData)
}
