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
    @Environment(\.showType) var showType
    @Binding private var columnVisibility: NavigationSplitViewVisibility
    var currentTokenGroup: Binding<TokenGroup> {
        tokenStorage.findGroup(by: tokenGroupID) ?? .constant(.empty)
    }

    // MARK: Animation Properties
    @State var currentToken: TokenModel = .empty
    @State var showDetailPage: Bool = false
    @State var detailOnAppear: Bool = false

    @Namespace var animation

    init(_ tokenGroupID: String, _ columnVisibility: Binding<NavigationSplitViewVisibility>) {
        self.tokenGroupID = tokenGroupID
        _columnVisibility = columnVisibility
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WrappingHStack(currentTokenGroup.wrappedValue.tokens, alignment: .leading, lineSpacing: 25.0) { token in
                Button(action: {
                    columnVisibility = .detailOnly
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 1.0, blendDuration: 0.7)) {
                            currentToken = token
                            showDetailPage = true
                            showType.wrappedValue = .text
                            tokenStorage.findToken(groupID: tokenGroupID, tokenID: token.id)?.wrappedValue.status = .editing
                        }
                    }
                }, label: {
                    if let tokenBinding = tokenStorage.findToken(groupID: tokenGroupID, tokenID: token.id) {
                        TokenView(token: tokenBinding)
                            .scaleEffect(currentToken.id == token.id && showDetailPage ? 1.5 : 0.9)
                            .matchedGeometryEffect(id: token.id, in: animation)
                    }
                })
                .buttonStyle(ScaleButtonStyle())
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .overlay {
            if showDetailPage {
                DetailView(token: $currentToken)
            }
        }
        .animation(.easeInOut, value: columnVisibility)
        .onChange(of: columnVisibility, perform: { value in
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 1.0, blendDuration: 0.7)) {
                currentToken = .empty
                showDetailPage = false
            }
        })
    }

    // MARK: Detail Page
    @ViewBuilder
    func DetailView(token: Binding<TokenModel>) -> some View {
        GeometryReader { proxy in
            Color.black
                .opacity(0.9)
                .ignoresSafeArea()
                .overlay {
                    ScrollView {
                        VStack {
                            HStack {
                                ForEach(ColorTheme.allCases) { theme in
                                    if theme != .empty {
                                        Button {
//                                            tokenStorage.changeTheme(groupID: tokenGroupID, tokenID: token.id, theme: theme)
                                            token.wrappedValue.colorTheme = theme
                                        } label: {
                                            theme.themePreviewImage
                                        }
                                        .buttonStyle(.plain)
                                        .scaleEffect(0.5)
                                    }
                                }
                            }
                            TokenView(token: token)
                                .matchedGeometryEffect(id: token.id, in: animation)
                        }
                    }
                    .scaleEffect(detailOnAppear ? 1.5 : 0.9, anchor: .top)
                }
                .toolbarRole(.navigationStack)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            detailOnAppear = false
                            withAnimation {
                                showDetailPage = false
                            }
                            currentToken = .empty
                        }, label: {
                            Text("Done")
                        })
                    }
                }
                .onAppear {
                    detailOnAppear = true
                }
                .animation(.easeInOut, value: detailOnAppear)
        }
    }
}

#Preview {
    NavigationStack {
        TokenGroupView(TokenStorage.mockData.sentences[2].id, .constant(.all))
            .environmentObject(TokenStorage.mockData)
    }
}
