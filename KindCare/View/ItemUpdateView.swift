//
//  ItemUpdateView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 View обновления данных продукта.
 */
struct ItemUpdateView: View {
    let item : ItemViewModel
    @ObservedObject private var updateItemVM = UpdateItemViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var itemViewState = ItemViewState()
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var data: Data?
    
    // Загрузка изображение.
    func loadImage(){
        guard let data = data else { return }
        
        image = Image(uiImage: (UIImage(data: data) ?? UIImage(data: self.itemViewState.itemImage)) ?? UIImage(imageLiteralResourceName: "default"))
    }
    
    var body: some View {
        VStack{
            // Если изображение новое, покажет его, иначе картинка продукта.
            if image != nil{
                image?
                    .resizable()
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 350, alignment: .topLeading)
            } else {
                Image(uiImage: UIImage(data: item.image)!)
                    .resizable()
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 350, alignment: .topLeading)
            }
            
            // Картинку можно поменять
            Button(action: {
                self.showingImagePicker = true
            }) {
                Text("Изменить")
            }
            
            // Поле для изменения названия.
            TextField("\(item.name)", text: $itemViewState.itemName)
                .padding(.leading)
                .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
                .font(.custom("SF-Pro", size: 20))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.init("PinkCustom"), lineWidth: 1))
            
            Spacer()
                .frame(height: 10)
            
            // DstePicker для изменения даты
            DatePicker("", selection: $itemViewState.itemOpenDate, in: ...Date(), displayedComponents: .date)
                .labelsHidden()
            
            Spacer()
                .frame(height: 10)
            
            // Поле для изменерния срока годности.
            TextField("\(item.months)", text: $itemViewState.itemMonths)
                .keyboardType(.numberPad)
                .padding(.leading)
                .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
                .font(.custom("SF-Pro", size: 20))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.init("PinkCustom"), lineWidth: 1))
            
            Spacer()
                .frame(height: 20)
            
            // Сохранение изменений
            Button(action: {
                if self.data != nil {
                    self.itemViewState.itemImage = self.data!
                }
                
                self.itemViewState.itemId = self.item.itemId
                
                let updated = self.updateItemVM.update(viewState: self.itemViewState)
                
                if updated{
                    self.presentationMode.wrappedValue.dismiss()
                }
            }){
                ButtonView(text: "Сохранить")
            }
            .padding(.bottom)
            .onAppear{
                self.itemViewState.itemName = self.item.name
                self.itemViewState.itemOpenDate = self.item.date
                self.itemViewState.itemMonths = String(self.item.months)
                self.itemViewState.itemImage = self.item.image
            }
        }
        .navigationBarTitle(itemViewState.itemName)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("chevron.backward")
                        .imageScale(.large)
                }
        })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(data: self.$data) }
    }
}

struct ItemUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item()
        return ItemUpdateView(item: ItemViewModel(item: item))
    }
}
