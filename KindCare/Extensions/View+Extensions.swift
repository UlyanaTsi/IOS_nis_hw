//
//  View+Extensions.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import SwiftUI

// Для небольшого уменьшения количества контейнеров.
extension View {
    func embedInNavigationView() -> some View{
        NavigationView{self}
    }
}
