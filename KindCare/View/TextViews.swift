//
//  TextViews.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct TextViews: View {
    var body: some View {
        VStack{
            Text("Привет! Это")
                .font(.custom("SF-Pro", size: 20))
            Text("Kind Care")
                .fontWeight(.bold)
            Text("С помощью Kind Care ты можешь легко находить cruelty-free и vegan косметику")
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 90)
                .font(.custom("SF-Pro", size: 20))
            
        }
    }
}

struct MainText: View{
    var text: String
    var body: some View {
        VStack{
            Text(text)
                .font(.custom("SF-Pro", size: 18))
                .frame(width: 370, height: 20, alignment: .leading)
            
        }
    }
}

struct HeaderText: View{
    var text: String
    var body: some View {
        VStack{
            Text(text)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            TextViews()
            MainText(text: "Название бренда")
            MainText(text: "Дата открытия")
            HeaderText(text: "Поиск")
        }
    }
}
