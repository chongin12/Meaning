//
//  File.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI
import PencilKit

struct TokenModel: Identifiable {
    var text: String
    // 그리기 요소 저장할 var 필요
    var colorTheme: ColorTheme
    var canvas: PKCanvasView
    var id = UUID()
    init(_ text: String, colorTheme: ColorTheme = .empty, canvas: PKCanvasView = PKCanvasView()) {
        self.text = text
        self.colorTheme = colorTheme
        self.canvas = canvas
    }
}

extension TokenModel: Hashable, Equatable {
    
}

extension TokenModel {
    public func imageFromCanvas(width: CGFloat, height: CGFloat, scale: CGFloat = 1.0) -> Image {
        Image(uiImage: canvas.drawing.image(from: CGRect(x: 0, y: 0, width: width, height: height), scale: 1.0))
            .resizable()
    }
}

extension TokenModel {
    static let mockData = TokenModel("mock data")
    static let empty = TokenModel("")
}
