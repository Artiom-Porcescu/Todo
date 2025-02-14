//
//  ItemModelUdef.swift
//  Todo
//
//  Created by Artiom Porcescu on 14.02.2025.
//

import Foundation

struct ItemModelUdef: Identifiable, Codable {
    var id: UUID
    let title: String
    let desc: String?
    let date: Date?
    let done: Bool
}
