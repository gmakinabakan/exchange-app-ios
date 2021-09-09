//
//  Caption.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct Caption: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(color)
    }
}

struct Caption_Previews: PreviewProvider {
    static var previews: some View {
        Caption(text: "Hello, World!", color: TextColor.PrimaryDark)
    }
}