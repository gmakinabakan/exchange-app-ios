//
//  Body.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct BodyText: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(color)
    }
}

struct BodyText_Previews: PreviewProvider {
    static var previews: some View {
        BodyText(text: "Hello, World!", color: TextColor.Primary)
    }
}
