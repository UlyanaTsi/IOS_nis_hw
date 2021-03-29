//
//  TextViews.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 Текст welcome view
 */
struct TextViews: View {
    var body: some View {
        VStack{
            Text("Привет! Это")
                .font(.custom("SF-Pro", size: 20))
            Text("Kind Care")
                .fontWeight(.bold)
            Text("С помощью Kind Care ты можешь легко находить cruelty-free и vegan косметику")
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 90)
                .font(.custom("SF-Pro", size: 20))
            
        }
    }
}

/*
 Основной текст
 */
struct MainText: View{
    var text: String
    var body: some View {
        VStack{
            Text(text)
                .font(.custom("SF-Pro", size: 18))
                .frame(minWidth: 0, maxWidth: 370, minHeight: 0, maxHeight: 20, alignment: .leading)
        }
    }
}

/*
 Текст заголовка
 */
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
