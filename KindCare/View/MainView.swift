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
        UINavigationBar.appearance().backgroundColor = .white
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

struct NavigationBarModifier: ViewModifier {
    private var backgroundColor: UIColor?
    private var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
