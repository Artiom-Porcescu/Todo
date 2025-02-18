//
//  ContentView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var listItemViewModel:ListItemViewModel
    
    var body: some View {
        
        VStack {
            if listItemViewModel.items.isEmpty {
                ContentUnavailableView("No items", systemImage: "xmark")
            } else {
                ListView()
            }
        }
        .padding()
        .navigationTitle("Todo List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink(destination: MainCreationView()) {
                Image(systemName: "plus")
                    .bold()
            }
        }
        
    }
}

//#Preview {
//    NavigationView {
//        WelcomeView()
//    }
//    .environmentObject(ListItemViewModel())
//}
