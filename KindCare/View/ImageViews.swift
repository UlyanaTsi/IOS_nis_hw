//
//  ImageViews.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct BarImage: View {
    var imageName : String!
    var body: some View {
        Image(imageName)
            .frame(width: 40, height: 40, alignment: .center)
            .foregroundColor(Color.init("BlueCustom"))
            .font(.largeTitle)
            .padding(.top)
    }
}

struct RoundedImage: View {
    var imageName : String!
    var body: some View {
        Image(imageName)
            .resizable()
            .cornerRadius(10)
    }
}

struct ImageViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            BarImage(imageName: "search")
            RoundedImage(imageName: "default")
        }
    }
}
