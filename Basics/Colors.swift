//
//  Colors.swift
//  Meaning
//
//  Created by 정종인 on 2/12/24.
//

import SwiftUI

enum Colors {
    // Basic Colors
    static let background = Color(#colorLiteral(red: 0.962918222, green: 0.9466977715, blue: 0.9340739846, alpha: 1))
    static let primary = Color(#colorLiteral(red: 0.3960784314, green: 0.3921568627, blue: 0.4862745098, alpha: 1))
    static let point = Color(#colorLiteral(red: 0.4670928717, green: 0.420773387, blue: 0.3651376963, alpha: 1))
    static let secondary = Color(#colorLiteral(red: 0.6904529333, green: 0.6523650289, blue: 0.5841861963, alpha: 1))
    static let tertiary = Color(#colorLiteral(red: 0.8666666667, green: 0.8078431373, blue: 0.737254902, alpha: 0.4))
    static let textBright = Color(#colorLiteral(red: 0.9924297929, green: 0.961620748, blue: 0.9232521057, alpha: 1))

    // Token Colors
    static let `default` = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.953145206, green: 0.9337275624, blue: 0.9166281819, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.3967114091, green: 0.3899573088, blue: 0.4867214561, alpha: 1))
    )
    static let smoky = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.3966313004, green: 0.393977046, blue: 0.4865756035, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.9924297929, green: 0.961620748, blue: 0.9232521057, alpha: 1))
    )
    static let pink = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.9819560647, green: 0.8634011745, blue: 0.8494151831, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.3529411554, green: 0.3529411554, blue: 0.3529411554, alpha: 1))
    )
    static let mint = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.7143284678, green: 0.8869290948, blue: 0.8293178678, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.1154541746, green: 0.3888575733, blue: 0.3271778226, alpha: 1))
    )
    static let peach = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.9981203675, green: 0.8216685057, blue: 0.7432682514, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.5437757969, green: 0.2704307437, blue: 0.07309421152, alpha: 1))
    )
    static let skyblue = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.6536021233, green: 0.7812765241, blue: 0.9044525027, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.1651205122, green: 0.2608709931, blue: 0.454865694, alpha: 1))
    )
    static let ravender = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.9024040103, green: 0.9002805352, blue: 0.9803736806, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.3152484, green: 0.240272969, blue: 0.361579597, alpha: 1))
    )
    static let vanilla = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.9528674483, green: 0.8980785012, blue: 0.6716421843, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.3342123628, green: 0.2339324355, blue: 0.052095972, alpha: 1))
    )
    static let turquoise = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.6856774688, green: 0.9326897264, blue: 0.9347382784, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.1262515187, green: 0.3679769635, blue: 0.377918303, alpha: 1))
    )
    static let violet = ColorPair(
        backgroundColor: Color(#colorLiteral(red: 0.7953740954, green: 0.6001297235, blue: 0.7875745296, alpha: 1)),
        textColor: Color(#colorLiteral(red: 0.2877532542, green: 0.2354047298, blue: 0.3821794391, alpha: 1))
    )
}

enum ColorTheme: String {
    case empty
    case smoky
    case pink
    case mint
    case peach
    case skyblue
    case ravender
    case vanilla
    case turquoise
    case violet

    var colorPair: ColorPair {
        switch self {
        case .empty:
            Colors.default
        case .smoky:
            Colors.smoky
        case .pink:
            Colors.pink
        case .mint:
            Colors.mint
        case .peach:
            Colors.peach
        case .skyblue:
            Colors.skyblue
        case .ravender:
            Colors.ravender
        case .vanilla:
            Colors.vanilla
        case .turquoise:
            Colors.turquoise
        case .violet:
            Colors.violet
        }
    }

    var backgroundColor: Color {
        colorPair.backgroundColor
    }

    var textColor: Color {
        colorPair.textColor
    }

    var themePreviewImage: Image {
        switch self {
        case .empty:
            Image(systemName: "circle")
        case .smoky:
            Image("smoky")
        case .pink:
            Image("pink")
        case .mint:
            Image("mint")
        case .peach:
            Image("peach")
        case .skyblue:
            Image("skyblue")
        case .ravender:
            Image("ravender")
        case .vanilla:
            Image("vanilla")
        case .turquoise:
            Image("turquoise")
        case .violet:
            Image("violet")
        }
    }
}

struct ColorPair {
    var backgroundColor: Color
    var textColor: Color
}
