//
//  TodoApp.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

@main
struct TodoApp: App {
    
    @StateObject var listViewModel: ListItemViewModel = ListItemViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
            }
            .environmentObject(listViewModel)
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
        }
    }
}
