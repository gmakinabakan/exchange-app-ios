//
//  Button.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct AnimatedButton: View {
    @State private var loading = false
    
    var text: String
    var action: () -> Void
    var isLoading: Bool
    
    var repeatingAnimation: Animation {
        Animation.linear
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Button(action: action) {
                Text(loading ? "" : text)
                    .foregroundColor(TextColor.OnPrimary)
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: loading ? 15 : .infinity)
                    .padding()
                    .background(PrimaryGradient)
                    .cornerRadius(30)
                    .animation(.default, value: loading)
                    .shadow(radius: 5, x: 0, y: 4)
            }
            .disabled(loading)
            .onAppear(perform: {
                if (isLoading) {
                    loading = true
                }
            })
            Circle()
                .fill(PrimaryGradient)
                .frame(width: 55, height: 55)
                .rotationEffect(Angle.degrees(loading ? 360 : 0))
                .animation(repeatingAnimation, value: loading)
                .opacity(loading ? 1 : 0)
                .animation(.default, value: loading)
                .shadow(radius: 5, x: 0, y: 4)
        }
    }
}

struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButton(text: "LET'S GO", action:{}, isLoading: false)
    }
}
