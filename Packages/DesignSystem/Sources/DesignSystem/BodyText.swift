//
//  Body.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

public struct BodyText: View {
    var text: String
    var color: Color
    
    public init(text: String, color:Color) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(ApplicationFont.Body)
            .foregroundColor(color)
    }
}

struct BodyText_Previews: PreviewProvider {
    static var previews: some View {
        BodyText(text: "Hello, World!", color: TextColor.primary)
    }
}
