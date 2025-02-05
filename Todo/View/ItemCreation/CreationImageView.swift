//
//  CreationImageView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct CreationImageView: View {
    
    let dimensions = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("grad")
                .resizable()
                .clipShape(Circle())
                .frame(width: dimensions, height: dimensions)
            Button {
                // change photo
            } label: {
                Text("Изменить")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
            }
        }
        
    }
}

#Preview {
    CreationImageView()
}
