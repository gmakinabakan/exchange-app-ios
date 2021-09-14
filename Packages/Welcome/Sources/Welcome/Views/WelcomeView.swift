//
//  WelcomeScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI
import Common
import DesignSystem

public struct WelcomeView: View {
    @EnvironmentObject var dependencyObject: WelcomeDependencyObject
    @EnvironmentObject var dataTransferObject: DataTransferObservableObject
    @State private var showWelcomeMessage = false
    @State private var navigateToNextScreen = false
    @State private var isLoading = false
    
    let inset:CGFloat = 10.0
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            if (navigateToNextScreen) {
                dependencyObject.nextView
            } else {
                GeometryReader { geometry in
                    VStack(alignment: .leading){
                        Headline1(text: dependencyObject.headerMessage, color: TextColor.Primary)
                            .padding(EdgeInsets(top: 8.0 * inset, leading: inset, bottom: 8.0 * inset, trailing: inset))
                        BodyText(text: dependencyObject.captionMessage, color: TextColor.Primary)
                            .padding(EdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset))
                        Spacer()
                        if(isLoading) {
                            AnimatedButton(text: "LET'S GO", action: getCurrencyList, isLoading: true)
                                .frame(width: geometry.size.width - (2.0 * inset), alignment: .center)
                                .padding(inset)
                        } else {
                            AnimatedButton(text: "LET'S GO", action: getCurrencyList, isLoading: false)
                                .frame(width: geometry.size.width - (2.0 * inset), alignment: .center)
                                .padding(inset)
                        }
                        
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
        .background(ApplicationBackgroundColor.BackgroundColor)
        .ignoresSafeArea()
    }
    
    func getCurrencyList() {
        isLoading.toggle()
        dependencyObject.initialDataAPI?.initialCall()
    }
}

extension WelcomeView: DataSourceBaseProtocol {
    public func initialDataRetrieved(data: Data) {
        if let dataKey = dependencyObject.uniqueDataKey {  dataTransferObject.DataDictionary[dataKey] = data
        }
        navigateToNextScreen.toggle()
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    class DummyAPI: APIBaseProtocol{
        var baseDelegate: DataSourceBaseProtocol?
        
        func initialCall() {
        }
        
    }
    
    static var previews: some View {
        Group {
            WelcomeView()
                .environmentObject(WelcomeDependencyObject(nextView: AnyView(WelcomeView()), headerMessage: "Welcome to the currency exchange rate application", captionMessage: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", initialDataAPI: DummyAPI(), uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7"))
        }
    }
}
