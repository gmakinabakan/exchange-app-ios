//
//  Constants.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import Foundation
import SwiftUI

public struct TextColor {
    public static var Primary: Color {
        return Color("TextPrimary", bundle: .module)
    }
    
    public static var Secondary: Color {
        return Color("TextSecondary", bundle: .module)
    }
    
    public static var OnPrimary: Color {
        return Color("TextOnPrimary", bundle: .module)
    }
}

public struct ApplicationColor {
    public static var Primary: Color {
        return Color("ApplicationPrimary", bundle: .module)
    }
    
    public static var Secondary: Color {
        return Color("ApplicationSecondary", bundle: .module)
    }
}

public struct ApplicationBackgroundColor {
    public static var BackgroundColor: Color {
        return Color("ApplicationBackground", bundle: .module)
    }
}

struct ApplicationFont {
    static var Headline1: Font {
        return Font.system(size: 42, weight: .heavy, design: .default)
    }
    
    static var Headline2: Font {
        return Font.system(size: 24, weight: .bold, design: .default)
    }
    
    static var Button: Font {
        return Font.system(size: 18, weight: .medium, design: .default)
    }
    
    static var Body: Font {
        return Font.system(size: 18, weight: .regular, design: .default)
    }
    
    static var Caption: Font {
        return Font.system(size: 16, weight: .regular, design: .default)
    }
    
}

public var PrimaryGradient = LinearGradient(gradient: Gradient(colors: [ApplicationColor.Secondary,ApplicationColor.Primary]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
