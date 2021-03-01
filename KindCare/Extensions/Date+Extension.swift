//
//  Date+Extension.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation

extension Date {
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        print(value)
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
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
}
