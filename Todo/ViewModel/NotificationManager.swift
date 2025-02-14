//
//  NotificationManager.swift
//  Todo
//
//  Created by Artiom Porcescu on 12.02.2025.
//
import Foundation
import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("Ошибка при запросе разрешения на оповещения - \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, date: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Ошибка при создании оповещения: \(error.localizedDescription)")
            } else {
                // add alert later on
                print("Назначено на \(date)")
            }
        }
        
    }
    
}
