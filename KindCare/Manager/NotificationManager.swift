//
//  NotificationManager.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 29.04.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func setNotification(date: Date, name: String, id: String){
        let notificationDate = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: date)
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Срок годности подходит к концу"
        content.body = "\(name) скоро испортится"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func removeNotification(id: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
