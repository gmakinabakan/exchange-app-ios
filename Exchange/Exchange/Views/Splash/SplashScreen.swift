//
//  SplashScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI
import DesignSystem

struct SplashScreen: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack(alignment: .leading){
                    Headline1(text: "Random", color: TextColor.onPrimary)
                    Headline1(text: "Currency", color: TextColor.onPrimary)
                    Headline1(text: "Exchange", color: TextColor.onPrimary)
                    Headline1(text: "Rate", color: TextColor.onPrimary)
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
