//
//  File.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

struct TokenModel: Identifiable {
    var text: String
    // 그리기 요소 저장할 var 필요
    var colorTheme: ColorTheme
    var status: StatusType
    var id = UUID()
    init(_ text: String, colorTheme: ColorTheme = .empty, status: StatusType = .default) {
        self.text = text
        self.colorTheme = colorTheme
        self.status = status
    }
}

extension TokenModel {
    enum StatusType {
        case `default`
        case editing
        case filled
    }
}

extension TokenModel: Hashable, Equatable {
    
}

extension TokenModel {
    static let mockData = TokenModel("mock data")
}
