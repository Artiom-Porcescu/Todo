//
//  ListItemImageView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListItemImageView: View {
    var selectedImageData: Data?
    
    var body: some View {
        if let data = selectedImageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
        }
    }
}

//#Preview {
//    ListItemImageView()
//}
