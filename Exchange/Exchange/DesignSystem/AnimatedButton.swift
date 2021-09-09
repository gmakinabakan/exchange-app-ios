//
//  Button.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct AnimatedButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
        Group {
            Button(action: action) {
                Text(text)
                    .foregroundColor(TextColor.PrimaryLight)
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
        .background(PrimaryGradient)
        .cornerRadius(30)
    }
}

struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButton(text: "LET'S GO", action:{})
    }
}