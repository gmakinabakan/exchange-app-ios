//
//  Headline2.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

public struct Headline2: View {
    var text: String
    var color: Color
    
    public init(text: String, color:Color) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(ApplicationFont.headline2)
            .foregroundColor(color)
    }
}

struct Headline2_Previews: PreviewProvider {
    static var previews: some View {
        Headline2(text: "Hello. World!", color: TextColor.primary)
    }
}
