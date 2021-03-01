//
//  ItemUpdateView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

struct ItemUpdateView: View {
    
    let item : ItemViewModel
    @State private var itemViewState = ItemViewState()
    
    var body: some View {
        VStack{
            RoundedImage(imageName: "default")
                .frame(width: 370, height: 400)
                .padding(.bottom)

            TextField(item.name, text: $itemViewState.itemName)
            .padding(.leading)
        }
    }
}

struct ItemUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item()
        return ItemUpdateView(item: ItemViewModel(item: item))
    }
}
