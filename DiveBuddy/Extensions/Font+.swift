//
//  Font+.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import SwiftUI

enum CustomFontSize: CGFloat {
    /// 36
    case one = 36
    /// 16
    case two = 16
    /// 17
    case three = 17
    /// 13
    case four = 13
}

extension Font {
    static func customFont(size: CustomFontSize, weight: Weight = .regular) -> Font {
        return Font.custom("Verdana,sanf-serif", size: size.rawValue).weight(weight)
    }
}

