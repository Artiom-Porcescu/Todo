//
//  ContentView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var items: [ItemModel] = [ItemModel]()
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    ContentUnavailableView("Hello", systemImage: "plus")
                } else {
                    ListView()
                }
                
            }
            .padding()
            .navigationTitle("Todo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .bold()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
