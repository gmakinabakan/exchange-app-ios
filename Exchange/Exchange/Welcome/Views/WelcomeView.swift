//
//  WelcomeScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var dependencyObject: WelcomeDependencyObject
    @EnvironmentObject var dataTransferObject: DataTransferObservableObject
    @State private var showWelcomeMessage = false
    @State private var navigateToNextScreen = false
    
    let inset:CGFloat = 10.0
    var body: some View {
        ZStack(alignment: .top) {
            if (navigateToNextScreen) {
                dependencyObject.nextView
            } else {
                GeometryReader { geometry in
                    VStack(alignment: .leading){
                        Headline1(text: "Welcome to the currency exchange rate application", color: TextColor.Primary)
                            .padding(EdgeInsets(top: 8.0 * inset, leading: inset, bottom: 8.0 * inset, trailing: inset))
                        BodyText(text: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", color: TextColor.Primary)
                            .padding(EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset))
                        Spacer()
                        AnimatedButton(text: "LET'S GO", action: getCurrencyList, isLoading: false)
                            .frame(width: geometry.size.width - (2.0 * inset), alignment: .center)
                            .padding(inset)
                    }
                    .onAppear(perform: {
                        dependencyObject.initialDataAPI?.baseDelegate = self
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showWelcomeMessage.toggle()
                        }
                        
                    })
                }
                
                if (showWelcomeMessage) {
                    CustomMessage(text: "We have a lot of new stuff for you")
                        .padding()
                        .onTapGesture {
                            showWelcomeMessage.toggle()
                        }
                }
            }
        }
    }
    
    func getCurrencyList() {
        dependencyObject.initialDataAPI?.initialCall()
    }
}

extension WelcomeView: DataSourceBaseProtocol {
    func initialDataRetrieved(data: Data) {
        if let dataKey = dependencyObject.uniqueDataKey {  dataTransferObject.DataDictionary[dataKey] = data
        }
        navigateToNextScreen.toggle()
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
        }
    }
}
