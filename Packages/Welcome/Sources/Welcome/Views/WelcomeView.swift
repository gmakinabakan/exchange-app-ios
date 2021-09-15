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
    let welcomeHelper = WelcomeHelper()
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            ApplicationBackgroundColor.backgroundColor
                .ignoresSafeArea()
            if (navigateToNextScreen) {
                dependencyObject.nextView
            } else {
                GeometryReader { geometry in
                    VStack(alignment: .leading){
                        Headline1(text: dependencyObject.headerMessage, color: TextColor.primary)
                            .padding(EdgeInsets(top: 11.0 * inset, leading: inset, bottom: 5.0 * inset, trailing: inset))
                        BodyText(text: dependencyObject.captionMessage, color: TextColor.primary)
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
                        welcomeHelper.delegate = self
                        welcomeHelper.initialize(initialAPI: dependencyObject.initialDataAPI, uniqueDataKey: dependencyObject.uniqueDataKey, dataTransferObject: dataTransferObject)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showWelcomeMessage.toggle()
                        }
                        
                    })
                }
                
                if (showWelcomeMessage) {
                    CustomMessage(text: dependencyObject.popupMessage)
                        .padding(EdgeInsets(top: 4 * inset, leading: inset, bottom: inset, trailing: inset))
                        .onTapGesture {
                            showWelcomeMessage.toggle()
                        }
                }
            }
        }
    }
    
    func getCurrencyList() {
        isLoading.toggle()
        welcomeHelper.loadData()
    }
}

extension WelcomeView: WelcomeDataProtocol {
    func dataRetrievalCompleted() {
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
                .environmentObject(WelcomeDependencyObject(nextView: AnyView(WelcomeView()), headerMessage: "Welcome to the currency exchange rate application", captionMessage: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", popupMessage: "We have a lot of new stuff for you", initialDataAPI: DummyAPI(), uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7"))
        }
    }
}
