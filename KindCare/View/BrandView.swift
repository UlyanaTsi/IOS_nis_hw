//
//  BrandView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 28.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 View детальной информации о бренде
 */
struct BrandView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    @State var isFavorite : Bool = false
    
    let brand : Brand
    
    init(brand: Brand) {
        self.brand = brand
    }
    
    // Проверка веганский ли бренд.
    func checkIfVegan() -> Bool{
        if (brand.isVegan == "vegan"){
            return true;
        }
        return false;
    }
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                    .frame(height: 40)
                
                // Лейблы этичного бренда
                HStack(){
                    RoundedImage(imageName: "bunny")
                        .frame(minWidth: 60, maxWidth: 60, minHeight: 60, maxHeight: 60, alignment: .leading)
                    
                    Text("Не тестируется на животных")
                        .font(.custom("SF-Pro", size: 18))
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 30, alignment: .leading)
                }
                .padding(.leading)
                
                // Лейблы веган бренда
                HStack(){
                    if (checkIfVegan()){
                        RoundedImage(imageName: "leaf")
                            .frame(minWidth: 60, maxWidth: 60, minHeight: 60, maxHeight: 60, alignment: .leading)
                        
                        Text("Веганский продукт")
                            .font(.custom("SF-Pro", size: 18))
                            .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 30, alignment: .leading)
                    }
                }
                .padding(.leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
            // Информация о лейблах
            VStack {
                Text("* \"Веганский продукт\" - продукция не содержит ингредиенты животного происхождения\n* \"Не тестируется на животных\" - значит, что ни на одном из этапов производства ни сам продукт, ни его ингредиенты не были протестированы на животных, а также продукция бренда не продаются в странах, где тестирование продукции на животных обязательно")
                    .multilineTextAlignment(.leading)
                    .font(.custom("SF-Pro", size: 18))
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 10, trailing: 20))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("\(brand.name!)")
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("chevron.backward")
                        .imageScale(.large)
                }
            },trailing:
            Button(action:{
                self.brand.isFavorite = !self.brand.isFavorite
                self.isFavorite.toggle()
                self.saveBrand()
            }){
                Image(systemName: self.brand.isFavorite || self.isFavorite ? "bookmark.fill" : "bookmark")
                    .imageScale(.large)
        })
    }
    
    // Сохранение бренда с измененным параметром isFavorite.
    func saveBrand(){
        do{
            try context.save()
        } catch { print("not saved")}
    }
}

struct BrandView_Previews: PreviewProvider {
    static var previews: some View {
        let b = Brand()
        return BrandView(brand: b)
    }
}
