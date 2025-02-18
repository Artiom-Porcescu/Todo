//
//  ItemModel.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable, Codable {
    let id: UUID
    let image: Data?
    let title: String
    let desc: String?
    let date: Date?
    let done: Bool
}

extension UIImage {
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 0.8) 
    }
}

extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}
