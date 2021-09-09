//
//  Constants.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

struct TextColor {
    
    private static var TextPrimaryDarkCode = 0x1B131F;
    private static var TextPrimaryLightCode = 0xFFFFFF;
    private static var TextSecondaryCode = 0x767886;
    private static var TextOnPrimaryCode = 0xFFFFFF;
    
    public static var PrimaryDark: Color {
        return Color(UIColor(rgb: TextColor.TextPrimaryDarkCode))
    }
    
    public static var PrimaryLight: Color {
        return Color(UIColor(rgb: TextColor.TextPrimaryLightCode))
    }
    
    public static var Secondary: Color {
        return Color(UIColor(rgb: TextColor.TextSecondaryCode))
    }
    
    public static var OnPrimary: Color {
        return Color(UIColor(rgb: TextColor.TextOnPrimaryCode))
    }
}

struct ApplicationColor {
    private static var PrimaryColorCode = 0xEE4DCD;
    private static var SecondaryColorCode = 0x6BA4FE;
    
    public static var Primary: Color {
        return Color(UIColor(rgb: ApplicationColor.PrimaryColorCode))
    }
    
    public static var Secondary: Color {
        return Color(UIColor(rgb: ApplicationColor.SecondaryColorCode))
    }
    
}

struct BackgroundColor {
    static var Light = 0xFFFFFF;
    static var Dark = 0x1C222B;
}

var PrimaryGradient = LinearGradient(gradient: Gradient(colors: [ApplicationColor.Secondary,ApplicationColor.Primary]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
