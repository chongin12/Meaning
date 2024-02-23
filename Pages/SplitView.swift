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

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                wordsSection()
                phrasessSection()
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
        }
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
            .foregroundStyle(self.selection == tokenGroup ? Colors.textBright : Color.black)
            .padding(.vertical, -6.3)
        }
    }
}

#Preview {
    SplitView()
        .environmentObject(TokenStorage.mockData)
}
