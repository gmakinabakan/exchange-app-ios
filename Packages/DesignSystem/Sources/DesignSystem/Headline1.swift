//
//  Headline1.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

public struct Headline1: View {
    var text: String
    var color: Color
    
    public init(text: String, color:Color) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(.system(size: 42, weight: .heavy))
            .foregroundColor(color)
    }
}

struct Headline1_Previews: PreviewProvider {
    static var previews: some View {
        Headline1(text: "Hello, World!", color: TextColor.Primary)
    }
}
