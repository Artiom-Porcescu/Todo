//
//  ListView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [ItemModel] = [
        ItemModel(title: "Buy milk", desc: "1 liter of milk"),
        ItemModel(title: "Go to the gym", desc: "Leg day workout"),
        ItemModel(title: "Read a book", desc: "Read 20 pages of Swift Programming"),
        ItemModel(title: "Meeting", desc: "Team sync at 3 PM"),
        ItemModel(title: "Grocery shopping", desc: "Buy eggs, bread, and fruits")
    ]

    
    var body: some View {
        List {
            //undone tasks
            Section {
                ForEach(items) { item in
                    ListItemView()
                }
            } header: {
                Text("Не завершенные")
            }
            
            //completed, put an if if there isnt any
            Section {
                Text("Hi")
            } header: {
                Text("Завершенные")
            }
        }
        .listStyle(PlainListStyle())
        
        
    }
}

#Preview {
    ListView()
}
