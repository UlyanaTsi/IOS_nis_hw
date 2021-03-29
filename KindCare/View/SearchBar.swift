//
//  SearchBar.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 14.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//


import SwiftUI

/*
Реализация SearchBar с помощью UISearchBar
*/
struct SearchBar : UIViewRepresentable {
    @Binding var text : String
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }
    
    func makeCoordinator() -> Cordinator {
        return Cordinator(text: $text)
    }
    
    /*
     Создание view
     */
    func makeUIView(context: UIViewRepresentableContext<SearchBar>)
        -> UISearchBar {
            
            let searchBar = UISearchBar(frame: .zero)
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.white.cgColor
            searchBar.delegate = context.coordinator
            searchBar.searchBarStyle = .minimal
            searchBar.placeholder = "Название бренда"
            searchBar.tintColor = UIColor(named: "RoseCustom")
            
            return searchBar
    }
    
    /*
     Обновляет view при вводе текста
     */
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    class Cordinator : NSObject, UISearchBarDelegate {
        @Binding var text : String
        init(text : Binding<String>)
        {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Hello"))
    }
}
