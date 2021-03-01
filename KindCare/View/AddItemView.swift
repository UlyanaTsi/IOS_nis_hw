//
//  AddItemView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addItemtVM = AddItemViewModel()
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            RoundedImage(imageName: "default")
                .frame(width: 370, height: 370)
                .padding(.bottom)
            
            HStack {
                Text("Добавьте название: ")
                .frame(width: 175, height: 30, alignment: .leading)
                .font(.custom("SF-Pro", size: 18))
                .padding(.leading)
                
                TextField("", text: $addItemtVM.itemName)
                    .frame(width: 175 , height: 30, alignment: .leading)
                    .font(.custom("SF-Pro", size: 18))
                    .padding(.trailing)
            }
            
            Divider()
            
            DatePicker(selection: $addItemtVM.itemOpenDate, in: ...Date(), displayedComponents: .date) {
                Text("")
            }  .padding(.trailing)
            
            Divider()
            
            HStack {
                Text("Количество месяцев на упаковке:")
                    .frame(width: 200, height: 60, alignment: .leading)
                    .font(.custom("SF-Pro", size: 18))
                    .padding(.leading)
                
                TextField("", value: $addItemtVM.itemMonths, formatter: NumberFormatter())
                .font(.custom("SF-Pro", size: 20))
                .padding(.leading)
            }
            
            Button("Добавить") {
                let saved = self.addItemtVM.saveItem()
                if saved {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .foregroundColor(Color.init("BlueCustom"))
            .font(.custom("SF-Pro", size: 20))
            .padding(.top)
        }.padding()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
