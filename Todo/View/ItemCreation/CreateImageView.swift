//
//  CreationImageView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI
import PhotosUI
import UIKit

struct CreateImageView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImageData: Data?
    @State private var showEditSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    let dimensions = UIScreen.main.bounds.width / 2

    var body: some View {
        ZStack(alignment: .bottom) {
            if let data = selectedImageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
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
            Button(action: {
                showEditSheet = true
            }) {
                Text("Изменить")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
            }
            .sheet(isPresented: $showEditSheet) {
                VStack(spacing: 20) {
                    Text("Выберите источник")
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()

                    HStack(spacing: 20) {
                        Button(action: {
                            sourceType = .camera
                            showImagePicker = true
                            showEditSheet = false
                        }) {
                            Text("Камера")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            sourceType = .photoLibrary
                            showImagePicker = true
                            showEditSheet = false
                        }) {
                            Text("Галерея")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.3)])
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImageData: $selectedImageData, sourceType: sourceType)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImageData: Data?
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                parent.selectedImageData = image.jpegData(compressionQuality: 0.8)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

//#Preview {
//    CreationImageView()
//}
