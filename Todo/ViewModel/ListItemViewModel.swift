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
    
    private var itemsUdef: [ItemModelUdef] = []
    private var imagesFm: [UIImage?] = []
    let udefKey = "items_list"
    
    
    init() {
        loadItems()
    }
    
    func addItem(item: ItemModel) {
        items.append(item)
    }
    
    func reverseDone(_for: ItemModel) {
        if let i = items.firstIndex(where: {$0.id == _for.id}) {
            items[i] = ItemModel(image: _for.image, title: _for.title, desc: _for.desc, date: _for.date, done: !_for.done)
        }
    }
    
    //deleteOnSwipe
    func deleteOnSwipeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    //SimpleDelete
    func deleteItem(toDelete: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == toDelete.id }) {
            items.remove(at: index)
        }
    }
    
    
    //editItem
    func editItem(updatedItem: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        }
    }

    
    //save
    func saveItems() {
        for item in items {
            itemsUdef.append(ItemModelUdef(id: item.id, title: item.title, desc: item.desc, date: item.date, done: item.done))
            imagesFm.append(item.image)
        }
        
        //uf save
        if let encodedData = try? JSONEncoder().encode(itemsUdef) {
            UserDefaults.standard.set(encodedData, forKey: udefKey)
        }
        
        
        //fmsave
    }
    
    func loadItems() {
        //uf load
//        UserDefaults.standard.removeObject(forKey: udefKey)
        
        guard
            let data = UserDefaults.standard.data(forKey: udefKey),
            let decodedData = try? JSONDecoder().decode([ItemModelUdef].self, from: data)
        else { return }
        
        self.itemsUdef = decodedData
        
        var filtered: [ItemModel] = []
        for item in itemsUdef {
            filtered.append(ItemModel(id: item.id, image: nil, title: item.title, desc: item.desc, date: item.date, done: item.done))
        }
        
        //fm load
    }
}
