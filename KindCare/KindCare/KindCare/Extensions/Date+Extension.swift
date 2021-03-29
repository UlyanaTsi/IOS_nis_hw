//
//  Date+Extension.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation

extension Date {
    /*
     Добаляет к дате количество переданных месяцев
     */
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
    /*
     Форматирование даты в строку
     */
    func getStringDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /*
     Форматирование строки в дату
     */
    func formatDate(string: String) -> Date{
        let formatter = DateFormatter()
        let format = "MMM d, yyyy"
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
}
