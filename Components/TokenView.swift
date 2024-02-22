//
//  TokenView.swift
//
//
//  Created by 정종인 on 2/12/24.
//

import SwiftUI

enum Dimension {
    enum TokenText {
        static let minWidth: CGFloat = 200
        static let minHeight: CGFloat = 64
    }
    enum TokenPicture {
        static let minHeight: CGFloat = 300
    }
}

struct TokenView: View {
    @Environment(\.showType) var showType
    @State private var textWidth: CGFloat = 0
    var minHeight: CGFloat {
        var height: CGFloat = 0
        if showType.wrappedValue == .text || showType.wrappedValue == .text_picture {
            height += Dimension.TokenText.minHeight
        }
        if showType.wrappedValue == .picture || showType.wrappedValue == .text_picture {
            height += Dimension.TokenPicture.minHeight
        }
        return height
    }
    @Binding var token: TokenModel

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            if (showType.wrappedValue == .picture || showType.wrappedValue == .text_picture) && token.status != .editing {
                ZStack(alignment: .bottom) {
                    Text(token.text)
                        .font(.tokenText)
                        .foregroundStyle(Color.clear)
                        .padding()
                        .frame(minHeight: minHeight)
                        .zIndex(1)
                        .background(
                            GeometryReader { textGeometry in
                                Color.clear
                                    .task {
                                        self.textWidth = textGeometry.size.width
                                    }
                            }
                        )

                    token.image
                        .frame(width: max(textWidth, Dimension.TokenText.minWidth))
                        .frame(minHeight: minHeight)
                        .zIndex(2)

//                    CanvasRepresentingView()
//                        .frame(width: max(textWidth, Dimension.TokenText.minWidth))
//                        .frame(minHeight: minHeight)
//                        .zIndex(2)
                }
            }
            if showType.wrappedValue == .text && token.status == .editing{
                ZStack(alignment: .bottom) {
                    Text(token.text)
                        .font(.tokenText)
                        .foregroundStyle(Color.clear)
                        .padding()
                        .frame(minHeight: minHeight)
                        .zIndex(1)
                        .background(
                            GeometryReader { textGeometry in
                                Color.clear
                                    .task {
                                        self.textWidth = textGeometry.size.width
                                    }
                            }
                        )

                    CanvasRepresentingView(canvasView: token.canvas)
                        .frame(width: max(textWidth, Dimension.TokenText.minWidth))
                        .frame(minHeight: minHeight)
                        .zIndex(2)
                }
            }
            if showType.wrappedValue == .text || showType.wrappedValue == .text_picture {
                Text(token.text)
                    .font(.tokenText)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(token.colorTheme.backgroundColor)
                            .frame(minWidth: Dimension.TokenText.minWidth, maxWidth: .infinity)
                    }
                    .foregroundStyle(token.colorTheme.textColor)
                    .zIndex(2)
            }
        }
        .frame(minWidth: Dimension.TokenText.minWidth)
        .background {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(Colors.point)
        }
        .animation(.bouncy, value: showType.wrappedValue)
        .transition(.identity)
    }
}


struct ConstTokenView: View {
    var token: TokenModel
    var showType: ShowType
    var minHeight: CGFloat {
        var height: CGFloat = 0
        if showType == .text || showType == .text_picture {
            height += Dimension.TokenText.minHeight
        }
        if showType == .picture || showType == .text_picture {
            height += Dimension.TokenPicture.minHeight
        }
        return height
    }
    init(token: TokenModel, showType: ShowType) {
        self.token = token
        self.showType = showType
    }
    var body: some View {
        ZStack(alignment: .top) {
            if showType == .picture || showType == .text_picture {
                Text("")
                    .frame(minHeight: minHeight)
            }
            if showType == .text || showType == .text_picture {
                Text(token.text)
                    .font(.tokenText)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(token.colorTheme.backgroundColor)
                            .frame(minWidth: Dimension.TokenText.minWidth)
                    }
                    .foregroundStyle(token.colorTheme.textColor)
            }
        }
        .frame(minWidth: Dimension.TokenText.minWidth)
        .background {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(Colors.tertiary)
        }
    }
}
