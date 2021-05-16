//
//  ImageViews.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 Картинки кнопок
 */
struct BarImage: View {
    var imageName : String!
    var body: some View {
        Image(imageName)
            .frame(minWidth: 0, maxWidth: 40, minHeight: 0, maxHeight: 40)
            .foregroundColor(Color.init("BlueCustom"))
            .font(.title)
            .padding(.top)
    }
}

/*
 Изображения со скругленными углами
 */
struct RoundedImage: View {
    var imageName : String!
    var body: some View {
        Image(imageName)
            .resizable()
            .cornerRadius(10)
    }
}
