//
//  CustomMessage.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

public struct CustomMessage: View {
    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .foregroundColor(TextColor.onPrimary)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .font(ApplicationFont.Caption)
            .padding()
            .background(ApplicationColor.primary)
            .cornerRadius(10)
    }
}

struct CustomMessage_Previews: PreviewProvider {
    static var previews: some View {
        CustomMessage(text: "Hello, World!")
    }
}
