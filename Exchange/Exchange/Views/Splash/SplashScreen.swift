//
//  SplashScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack(alignment: .leading){
                    Headline1(text: "Random", color: TextColor.PrimaryLight)
                    Headline1(text: "Currency", color: TextColor.PrimaryLight)
                    Headline1(text: "Exchange", color: TextColor.PrimaryLight)
                    Headline1(text: "Rate", color: TextColor.PrimaryLight)
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
