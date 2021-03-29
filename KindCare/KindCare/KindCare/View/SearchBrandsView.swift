//
//  SearchBrandsView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 View cо строкой поиска по брендам.
 */
struct SearchBrandsView: View {
    // Получеам список брендов.
    @FetchRequest(entity: Brand.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Brand.name, ascending: true)
    ]) var brands: FetchedResults<Brand>
    
    @State private var searchText : String = ""
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            List(brands.filter({ searchText.isEmpty ? false : $0.name!.contains(searchText) })) { (brand : Brand) in
                
                // При нажатии на ячейку бренда откроется страница с детальной информацией.
                NavigationLink(destination: BrandView(brand: brand)){
                    Text("\(brand.name!)")
                    .font(.custom("SF-Pro", size: 18))
                }
            }
        }
        .navigationBarTitle("Поиск")
        .embedInNavigationView()
    }
}

struct SearchBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBrandsView()
    }
}
