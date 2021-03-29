//
//  FavoriteBrandsView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 View cо списком избранных брендов пользователя
 */
struct FavouriteBrandsView: View {
    // Получили список.
    @FetchRequest(entity: Brand.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Brand.name, ascending: true)
    ]) var brands: FetchedResults<Brand>
    
    var body: some View {
        VStack{
            // Если бренд isFavorite, то он выводится в список.
            List(brands.filter({ return $0.isFavorite })) { (brand : Brand) in
                
                NavigationLink(destination: BrandView(brand: brand)){
                    Text("\(brand.name!)")
                        .font(.custom("SF-Pro", size: 18))
                }
            }
        }
        .navigationBarTitle("Избранное")
        .embedInNavigationView()
    }
}

struct FavouriteBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBrandsView()
    }
}
