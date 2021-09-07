//
//  ContentView.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    var body: some View {
        if(showSplashScreen) {
            SplashScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                      withAnimation() {
                        showSplashScreen = false
                      }
                    }
                }
        } else {
            Text("HELLO")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

