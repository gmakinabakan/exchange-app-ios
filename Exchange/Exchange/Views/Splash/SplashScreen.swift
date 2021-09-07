//
//  SplashScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

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

struct SplashScreen: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack(alignment: .leading){
                    Headline1(text: "Random", color: TextColor.TextPrimaryLight)
                    Headline1(text: "Currency", color: TextColor.TextPrimaryLight)
                    Headline1(text: "Exchange", color: TextColor.TextPrimaryLight)
                    Headline1(text: "Rate", color: TextColor.TextPrimaryLight)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .padding()
            }
            .background(PrimaryGradient)
            .ignoresSafeArea()
            
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
