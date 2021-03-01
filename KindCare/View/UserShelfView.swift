//
//  UserShelfView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct UserShelfView: View {
    
    @ObservedObject private var itemListVM = ItemsListViewModel()
    @State private var isPresented: Bool = false
    
    
    private func deleteItem(at indexSet: IndexSet) {
        
        var deleted = false
        
        indexSet.forEach { index in
            let item = itemListVM.items[index]
            deleted = itemListVM.deleteItem(item)
        }
        
        if deleted {
            itemListVM.fetchAllItems()
        }
        
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(itemListVM.items, id: \.itemId) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        ItemCellView(itemName: item.name, itemDate: item.date, itemMonths: item.months)
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
        .navigationBarItems(leading: HeaderText(text: "Моя полка"), trailing: Button("+") {
            self.isPresented = true
        })
            .embedInNavigationView()
    }
}

struct ItemCellView: View {
    var itemName: String
    var itemDate: Date
    var itemMonths: Int64
    
    var body: some View {
        HStack{
            RoundedImage(imageName: "default")
            .frame(width: 70, height: 70)
            
            VStack{
                MainText(text: itemName)
                MainText(text: itemDate.getFormattedDate(format: "MMM d, yyyy"))
                MainText(text: itemDate.adding(.month, value: Int(itemMonths)).getFormattedDate(format: "MMM d, yyyy"))
            }
        }
    }
}

struct UserShelfView_Previews: PreviewProvider {
    static var previews: some View {
        UserShelfView()
    }
}
