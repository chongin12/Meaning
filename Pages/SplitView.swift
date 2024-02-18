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
                        ForEach(ShowType.allCases) { type in
                            switch type {
                            case .text:
                                Image(systemName: "rectangle")
                                    .tag(ShowType.text)
                            case .text_picture:
                                Image(systemName: "rectangle.tophalf.inset.filled")
                                    .tag(ShowType.text_picture)
                            case .picture:
                                Image(systemName: "rectangle.fill")
                                    .tag(ShowType.picture)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    Button(action: {

                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.brown)
    }

    private func wordsSection() -> some View {
        Section("Words") {
            tokenListItems(tokenGroups: tokenStorage.words)
        }
    }

    private func phrasessSection() -> some View {
        Section("Phrases") {
            tokenListItems(tokenGroups: tokenStorage.phrases)
        }
    }

    private func sentencesSection() -> some View {
        Section("Sentences") {
            tokenListItems(tokenGroups: tokenStorage.sentences)
        }
    }

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
            .background(self.selection == tokenGroup ? selectedLinearGradient() : unSelectedLinearGradient(), in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
    }

    private func selectedLinearGradient() -> LinearGradient {
        LinearGradient(colors: [Color.clear, Color.clear, Colors.tertiary], startPoint: .leading, endPoint: .trailing)
    }

    private func unSelectedLinearGradient() -> LinearGradient {
        LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing)
    }
}

#Preview {
    SplitView()
        .environmentObject(TokenStorage.mockData)
}
