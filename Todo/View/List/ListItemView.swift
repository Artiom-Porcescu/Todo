//
//  ListItemView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListItemView: View {
    
    @State var done = false
    @State var item: ItemModel = ItemModel(title: "title", desc: "dsf")
    
    
    var body: some View {
        
        HStack(alignment: .top) {
            if !done {
                ListItemImageView()
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Buy milk")
                    .foregroundColor(done ? .secondary : .black)
                    .font(.title2)
                    .bold()
                    .strikethrough(done, color: .secondary)
                Text("Grease 20% and some more products")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .strikethrough(done, color: .secondary)
                if item.date != nil {
                    DateItemView()
                }
            }
            .padding(.leading)
            Spacer()
            Image(systemName: done ? "checkmark.circle" : "circle")
                .onTapGesture {
                    withAnimation(.bouncy(duration: 0.5)) {
                        done.toggle()
                    }
                }
                .font(.title)
        }
        .padding()
        .background(.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
        
    }
}

#Preview {
    ListItemView()
}
