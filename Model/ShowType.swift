//
//  ShowType.swift
//  Meaning
//
//  Created by 정종인 on 2/14/24.
//

import SwiftUI

enum ShowType {
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

private struct ShowTypeKey: EnvironmentKey {
    static var defaultValue: Binding<ShowType> = .constant(.text)
}

extension EnvironmentValues {
    var showType: Binding<ShowType> {
        get { self[ShowTypeKey.self] }
        set { self[ShowTypeKey.self] = newValue }
    }
}
