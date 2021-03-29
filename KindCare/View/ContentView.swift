//
//  ContentView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

// Добавили расширение для параметра
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

/*
 Первоначальное view.
 Если пользователь только загрузил приложение,
 то покажет WelcomeView, иначе MainView
 */
struct ContentView: View {
    @State var showWelcomeScreen : Bool = true
    
    var body: some View {
        VStack{
            if (UserDefaults.standard.welcomeScreenSeen){
                MainView()
            } else {
                MainView()
                    .sheet(isPresented: $showWelcomeScreen){
                        WelcomeScreen()
                            .onDisappear(perform: { self.showWelcomeScreen = false })
                }
            }
        }
    }
}

/*
 View с приветсвием и краткой информацией о приложении.
 */
struct WelcomeScreen: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View{
        VStack{
            Image("welcomepage_image")
                .resizable()
                .frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 500, alignment: .top)
            
            TextViews()
            
            Spacer()
                .frame(height: 30)
            
            Button(action: { self.presentationMode.wrappedValue.dismiss() }){
                ButtonView(text: "Начать")
                    .padding(.bottom)
            }
        }
        .onAppear(perform: {
            UserDefaults.standard.welcomeScreenSeen = true })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
