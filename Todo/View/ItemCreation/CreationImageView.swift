//
//  CreationImageView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI
import PhotosUI

struct CreationImageView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImage: UIImage?
    
    let dimensions = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: dimensions, height: dimensions)
                    .scaledToFit()
            } else {
                Image("grad")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: dimensions, height: dimensions)
            }
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Изменить")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImage = UIImage(data: data)
                    }
                }
            }
        }
        
        //bottomsheet
        //photo
        //gallery
        //deletePhoto
        
    }
}

//#Preview {
//    CreationImageView()
//}
