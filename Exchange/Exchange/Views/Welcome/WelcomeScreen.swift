//
//  WelcomeScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct WelcomeScreen: View {
    let inset:CGFloat = 10.0
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                Headline1(text: "Welcome to the currency exchange rate application", color: TextColor.TextPrimaryDark)
                    .padding(EdgeInsets(top: 5.0 * inset, leading: inset, bottom: 5.0 * inset, trailing: inset))
                BodyText(text: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", color: TextColor.TextPrimaryDark)
                    .padding(EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset))
                Spacer()
                AnimatedButton(text: "LET'S GO")
                    .frame(width: geometry.size.width - 2.0 * inset, alignment: .center)
                    .padding(inset)
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
