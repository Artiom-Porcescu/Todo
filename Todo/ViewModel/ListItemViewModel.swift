//
//  ListItemViewModel.swift
//  Todo
//
//  Created by Artiom Porcescu on 11.02.2025.
//

import Foundation
import SwiftUI

class ListItemViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let udefKey = "items_list"
    
    init() {
        loadItems()
    }
    
    func addItem(item: ItemModel) {
        items.append(item)
    }
    
    func reverseDone(for model: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == model.id}) {
            items[index] = ItemModel(id: items[index].id, image: model.image, title: model.title, desc: model.desc, date: model.date, done: !model.done)
        }
        saveItems()
    }
    
    func deleteOnSwipeItems(at offsets: IndexSet, isCompletedSection: Bool) {
        let sectionItems = isCompletedSection ? items.filter { $0.done } : items.filter { !$0.done }
        
        for offset in offsets {
            let itemToDelete = sectionItems[offset]
            items.removeAll { $0.id == itemToDelete.id }
        }
    }

    
    func deleteItem(toDelete: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == toDelete.id }) {
            items.remove(at: index)
        }
    }
    
    
    func editItem(updatedItem: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: udefKey)
        }
    }

    func loadItems() {
        guard
            let data = UserDefaults.standard.data(forKey: udefKey),
            let decodedData = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = decodedData
    }
}
