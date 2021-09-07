//
//  Constants.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import Foundation
import SwiftUI

struct TextColor {
    static var TextPrimaryDark = 0x1B131F;
    static var TextPrimaryLight = 0xFFFFFF;
    static var TextSecondary = 0x767886;
    static var TextOnPrimary = 0xFFFFFF;
}

struct GlobalColor {
    static var Primary = 0xEE4DCD;
    static var Secondary = 0x6BA4FE;
}

struct BackgroundColor {
    static var Light = 0xFFFFFF;
    static var Dark = 0x1C222B;
}

var PrimaryGradient = LinearGradient(gradient: Gradient(colors: [Color(UIColor(rgb: GlobalColor.Secondary)), Color(UIColor(rgb: GlobalColor.Primary))]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
