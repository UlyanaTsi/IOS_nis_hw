//
//  ContentView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 Главный вид - контейнер для всех остальных.
 */
struct MainView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorColor = UIColor(named: "RoseCustom")
    }
    
    // Меню
    var body: some View {
        TabView{
            UserShelfView()
                .tabItem{
                    BarImage(imageName: "shelf")
            }
            SearchBrandsView()
                .tabItem{
                    BarImage(imageName: "search")
                    
            }
            FavouriteBrandsView()
                .tabItem{
                    BarImage(imageName: "heart")
            }
            
        }
        .accentColor(Color.init("BlueCustom"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
