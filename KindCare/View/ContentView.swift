//
//  ContentView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

// добавили расширение для параметра
extension UserDefaults{
    var welcomeScreenSeen: Bool{
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenSeen") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenSeen")
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack{
            if UserDefaults.standard.welcomeScreenSeen{
                MainView()
            } else {
                WelcomeScreen()
            }
        }
    }
}

// сделать другой файл для этого
struct WelcomeScreen: View {
    var body: some View{
        ZStack{
            NavigationView{
                VStack{
                    Image("welcomepage_image")
                        .resizable()
                        .frame(width: 337.0, height: 390.0)
                    TextViews()
                    NavigationLink(destination: UserShelfView()){
                        StartButonView()
                    }
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {UserDefaults.standard.welcomeScreenSeen = true})
        }
    }
}


struct StartButonView: View {
    let colors = Gradient(colors: [Color.init("PinkCustom"), Color.init("OrangeCustom")])
    var body: some View {
        Text("Начать")
            .font(.custom("SF-Pro", size: 20))
            .fontWeight(.regular)
            .foregroundColor(.white)
            .frame(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: colors, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
