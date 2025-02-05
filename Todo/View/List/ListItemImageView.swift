//
//  ListItemImageView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListItemImageView: View {
    var body: some View {
        Image("grad")
            .resizable()
            .clipShape(Circle())
            .frame(width: 70, height: 70)
    }
}

#Preview {
    ListItemImageView()
}
