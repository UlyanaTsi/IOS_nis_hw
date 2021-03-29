//
//  BrandViewModel.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 14.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import Combine

/*
ViewModel бренда.
*/
class BrandViewModel : ObservableObject{
    /*
    Список брендов
    */
    @Published private (set) var brands: [Brand] = []
    
    /*
    ViewModel списка элемента.
    */
    @Published var searchText: String = String()
}
