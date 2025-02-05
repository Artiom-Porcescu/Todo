//
//  ItemModel.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable {
    var id = UUID()
    let image: Image? = nil
    let title: String
    let desc: String?
    let date: Date? = nil
}
