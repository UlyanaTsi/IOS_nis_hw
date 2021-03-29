//
//  ButtonView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 28.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 Reusable view для кнопки.
 */
struct ButtonView: View {
    let text : String
    let colors = Gradient(colors: [Color.init("PinkCustom"), Color.init("OrangeCustom")])
    var body: some View {
        Text(text)
            .font(.custom("SF-Pro", size: 20))
            .fontWeight(.regular)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: 200, minHeight: 60, maxHeight: 60)
            .background(LinearGradient(gradient: colors, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15)
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Действие")
    }
}
