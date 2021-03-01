//
//  ItemDetailView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    
    let item: ItemViewModel
    @ObservedObject private var updateVM = UpdateViewModel()
    @State private var itemViewState = ItemViewState()
    
    var body: some View {
        VStack {
            
            TextField(item.name, text: $itemViewState.itemName)
            
//            Button("Update") {
//                self.itemViewState.itemId = self.item.itemId
//                self.updateVM.update(itemViewState: self.itemViewState)
//            }
//
//            .onAppear {
//                self.$itemViewState.name = self.item.name
//                self.$itemViewState.body = self.post.body
//            }
           
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let item = Item()
        return ItemDetailView(item: ItemViewModel(item: item))
    }
}
