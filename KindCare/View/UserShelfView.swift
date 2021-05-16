//
//  UserShelfView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 View с добавленными пользователем продуктами.
 */
struct UserShelfView: View {
    @ObservedObject private var itemListVM = ItemsListViewModel()
    @State private var isPresented: Bool = false
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(named: "BlueCustom")
    }
    
    /*
     Удаление объекта.
     */
    private func deleteItem(at index: IndexSet) {
        var deleted = false
        
        index.forEach { index in
            let item = itemListVM.items[index]
            deleted = itemListVM.deleteItem(item)
            NotificationManager.shared.removeNotification(id: item.itemId)
        }
        
        if deleted {
            itemListVM.fetchAllItems()
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(itemListVM.items, id: \.itemId) { item in
                        NavigationLink(destination: ItemUpdateView(item: item)) {
                            
                            ItemCellView(itemName: item.name, itemDate: item.date, itemMonths: item.months, itemImage: item.image)
                        }
                    }.onDelete(perform: self.deleteItem)
                }
                    
                .onAppear {
                    self.itemListVM.fetchAllItems()
                }
                    
                .sheet(isPresented: $isPresented, onDismiss: {
                    self.itemListVM.fetchAllItems()
                }) {
                    AddItemView()
                }
            }
            .navigationBarTitle("Полка")
            .navigationBarItems(leading: Text(""), trailing: Button(action: { self.isPresented = true }) {
                Image(systemName: "plus")
                    .imageScale(.large)
            })
            
        }
        .navigationBarColor(backgroundColor: .white, titleColor: UIColor(named: "PinkCustom") )
    }
}

/*
 Ячейка в списке продуктов.
 */
struct ItemCellView: View {
    var itemName: String
    var itemDate: Date
    var itemMonths: Int64
    var itemImage: Data
    
    var body: some View {
        HStack{
            Image(uiImage: UIImage(data: itemImage) ?? UIImage(imageLiteralResourceName: "default"))
                .resizable()
                .cornerRadius(10)
                .frame(minWidth: 0, maxWidth: 70, minHeight: 0, maxHeight: 70)
            
            VStack{
                MainText(text: itemName)
                MainText(text: itemDate.getStringDate(format: "MMM d, yyyy"))
                MainText(text: itemDate.adding(.month, value: Int(itemMonths)).getStringDate(format: "MMM d, yyyy"))
            }
        }
    }
}
