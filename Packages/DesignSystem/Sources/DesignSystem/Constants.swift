//
//  Constants.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import Foundation
import SwiftUI

public struct TextColor {
    public static var primary: Color {
        return Color("TextPrimary", bundle: .module)
    }
    
    public static var secondary: Color {
        return Color("TextSecondary", bundle: .module)
    }
    
    public static var onPrimary: Color {
        return Color("TextOnPrimary", bundle: .module)
    }
}

public struct ApplicationColor {
    public static var primary: Color {
        return Color("ApplicationPrimary", bundle: .module)
    }
    
    public static var secondary: Color {
        return Color("ApplicationSecondary", bundle: .module)
    }
}

public struct ApplicationBackgroundColor {
    public static var backgroundColor: Color {
        return Color("ApplicationBackground", bundle: .module)
    }
}

public struct ApplicationGradient {
    public static var secondaryToPrimary: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [ApplicationColor.secondary,ApplicationColor.primary]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
    }
}

struct ApplicationFont {
    static var headline1: Font {
        return Font.system(size: 42, weight: .heavy, design: .default)
    }
    
    static var headline2: Font {
        return Font.system(size: 24, weight: .bold, design: .default)
    }
    
    static var button: Font {
        return Font.system(size: 18, weight: .medium, design: .default)
    }
    
    static var body: Font {
        return Font.system(size: 18, weight: .regular, design: .default)
    }
    
    static var caption: Font {
        return Font.system(size: 16, weight: .regular, design: .default)
    }
    
}
