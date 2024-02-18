//
//  ShowType.swift
//  Meaning
//
//  Created by 정종인 on 2/14/24.
//

import SwiftUI

enum ShowType: String, CaseIterable {
    case text
    case text_picture
    case picture

    mutating func convert() {
        switch self {
        case .text:
            self = .text_picture
        case .text_picture:
            self = .picture
        case .picture:
            self = .text
        }
    }
}

extension ShowType: Identifiable {
    var id: Self { self }
}

private struct ShowTypeKey: EnvironmentKey {
    static var defaultValue: Binding<ShowType> = .constant(.text)
}

extension EnvironmentValues {
    var showType: Binding<ShowType> {
        get { self[ShowTypeKey.self] }
        set { self[ShowTypeKey.self] = newValue }
    }
}
