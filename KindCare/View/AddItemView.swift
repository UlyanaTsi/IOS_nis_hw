//
//  AddItemView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI
import Combine

/*
 View добавление продукта в список.
 */
struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addItemVM = AddItemViewModel()
    
    @State private var showAlert = false
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var data: Data?
    
    // Загрузка изображения.
    func loadImage(){
        guard let data = data else { return}
        
        image = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "default"))
    }
    
    var body: some View {
        VStack {
            // Добавление изображения
            if image != nil {
                image?
                    .resizable()
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 350, alignment: .topLeading)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
            } else {
                Button(action: {
                    self.showingImagePicker = true
                }) {
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color.init("BlueCustom"))
                        .font(.largeTitle)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            }
            
            // Поле для названия
            TextField("Название", text: $addItemVM.itemName)
                .padding(.leading)
                .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
                .font(.custom("SF-Pro", size: 20))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.init("PinkCustom"), lineWidth: 1))
            
            Spacer()
                .frame(height: 20)
            
            // Выбор даты открытия
            DatePicker("", selection: $addItemVM.itemOpenDate, in: ...Date(), displayedComponents: .date)
                .labelsHidden()
            
            Spacer()
                .frame(height: 20)
            
            // Поле срока годности
            TextField("Количество месяцев", text: $addItemVM.itemMonths)
                .padding(.leading)
                .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
                .font(.custom("SF-Pro", size: 20))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.init("PinkCustom"), lineWidth: 1))
            
            Spacer()
                .frame(height: 60)
            
            // Кнопка добавить
            Button(action: {
                if self.data != nil {
                    self.addItemVM.itemImage = self.data!
                }
                
                // Проверяем верность заполнения формы
                if (self.addItemVM.itemMonths.count <= 2 && Int(self.addItemVM.itemMonths) != nil && self.addItemVM.itemName.count > 0) {
                    let saved = self.addItemVM.saveItem()
                    if saved {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    self.showAlert = true
                }
                
            }) {
                ButtonView(text: "Добавить")
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $showingImagePicker,
               onDismiss: loadImage){
                ImagePicker(data: self.$data) }
        .alert(isPresented: $showAlert, content : {
            Alert(
                title: Text("Ошибка"),
                message: Text("Пожалуйста, проверьте верность заполненных данных."),
                dismissButton: .default(Text("OK"))
            )
        })
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
