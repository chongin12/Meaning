//
//  SplitView.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

struct SplitView: View {
    @State private var selection: TokenGroup?
    @EnvironmentObject var tokenStorage: TokenStorage
    var body: some View {
        NavigationSplitView {
            List {
                wordsSection()
                phrasessSection()
            }
        } detail: {
            if let selection {
                TokenGroupView(selection.id)
            } else {
                Text("choose any Words, Phrases, or Sentences in Sidebar")
            }
        }
        .navigationBarBackButtonHidden()
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
