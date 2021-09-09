//
//  Headline2.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

struct Headline2: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(color)
    }
}

struct Headline2_Previews: PreviewProvider {
    static var previews: some View {
        Headline2(text: "Hello. World!", color: TextColor.Primary)
    }
}
