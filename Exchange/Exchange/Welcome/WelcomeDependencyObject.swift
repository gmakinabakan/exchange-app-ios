//
//  WelcomeDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine
import SwiftUI

final class WelcomeDependencyObject: ObservableObject {
    var nextView: AnyView
    
    init(nextView: AnyView) {
        self.nextView = nextView
    }
}
