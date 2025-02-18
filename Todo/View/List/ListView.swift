//
//  ListView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListItemViewModel
    
    var body: some View {
        List {
            let completedItems = listViewModel.items.filter { $0.done }
            let pendingItems = listViewModel.items.filter { !$0.done }
            
            if !pendingItems.isEmpty {
                Section {
                    ForEach(pendingItems) { item in
                        ListItemView(item: item)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .background(
                                NavigationLink("",
                                               destination: MainCreationView(item: item)
                                              )
                                        .opacity(0)
                                )
                        
                    }
                    .onDelete { indexSet in
                        listViewModel.deleteOnSwipeItems(at: indexSet, isCompletedSection: false)
                    }
                } header: {
                    Text("Не завершенные")
                        .foregroundStyle(.secondary)
                        .padding(.leading, 10)
                }
            }

            if !completedItems.isEmpty {
                Section {
                    ForEach(completedItems) { item in
                        ListItemView(item: item)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        listViewModel.deleteOnSwipeItems(at: indexSet, isCompletedSection: true)
                    }
                } header: {
                    Text("Завершенные")
                        .foregroundStyle(.secondary)
                        .padding(.leading, 10)
                }
            }
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    NavigationView {
//        ListView()
//    }
//    .environmentObject(ListItemViewModel())
//}
