//
//  CustomMessage.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

struct CustomMessage: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(TextColor.OnPrimary)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .background(ApplicationColor.Primary)
            .cornerRadius(10)
    }
}

struct CustomMessage_Previews: PreviewProvider {
    static var previews: some View {
        CustomMessage(text: "Hello, World!")
    }
}