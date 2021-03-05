//
//  Date+Extension.swift
//  HabbitsApp
//
//  Created by Ульяна Цимбалистая on 28.02.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation

/*
    Расширение для работы с датами.
 */
extension Date {
    
    func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toStringDate(string: String) -> Date{
        let formatter = DateFormatter()
        let format = "MMM d, yyyy"
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    func stringDate() -> String{
        let formatter = DateFormatter()
        let format = "MMM d, yyyy"
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
