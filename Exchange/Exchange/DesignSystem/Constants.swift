//
//  Constants.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import Foundation
import SwiftUI

struct TextColor {
    public static var Primary: Color {
        return Color("TextPrimary")
    }
    
    public static var Secondary: Color {
        return Color("TextSecondary")
    }
    
    public static var OnPrimary: Color {
        return Color("TextOnPrimary")
    }
}

struct ApplicationColor {
    public static var Primary: Color {
        return Color("ApplicationPrimary")
    }
    
    public static var Secondary: Color {
        return Color("ApplicationSecondary")
    }
}

struct BackgroundColor {
    public static var UniversalColor: Color {
        return Color("ApplicationBackground")
    }
}

var PrimaryGradient = LinearGradient(gradient: Gradient(colors: [ApplicationColor.Secondary,ApplicationColor.Primary]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
