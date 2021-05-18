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
    @State private var tabBar: UITabBar! = nil
    
    var body: some View {
        VStack{
            // Если бренд isFavorite, то он выводится в список.
            List(brands.filter({ return $0.isFavorite })) { (brand : Brand) in
                
                NavigationLink(destination:
                    BrandView(brand: brand)
                        .onAppear { self.tabBar.isHidden = true }
                        .onDisappear { self.tabBar.isHidden = false } )
                {
                    BrandCell(brand: brand)
                }
            }
        }
        .background(TabBarAccessor { tabbar in
            DispatchQueue.main.async {
                self.tabBar = tabbar
            }
        })
        .navigationBarTitle("Избранное")
        .embedInNavigationView()
    }
}

struct BrandCell : View {
    var brand : Brand
    var body: some View{
        HStack{
            Text("\(brand.name!)")
            .font(.custom("SF-Pro", size: 20))
            Image("bunny_l")
            .resizable()
            .cornerRadius(10)
            .frame(minWidth: 0, maxWidth: 40, minHeight: 0, maxHeight: 40)
            if(brand.isVegan == "vegan"){
                Image("leaf_l")
                .resizable()
                .cornerRadius(10)
                .frame(minWidth: 0, maxWidth: 40, minHeight: 0, maxHeight: 40)
            }
        }
    }
}

struct FavouriteBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBrandsView()
    }
}
