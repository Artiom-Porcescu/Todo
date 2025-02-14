//
//  ListItemView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct ListItemView: View {
    
    @EnvironmentObject var listItemViewModel: ListItemViewModel
    var item: ItemModel
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            if !item.done {
                ListItemImageView(selectedImage: item.image)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .foregroundColor(item.done ? .secondary : .black)
                    .font(.title2)
                    .bold()
                    .strikethrough(item.done, color: .secondary)
                Text(item.desc ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .strikethrough(item.done, color: .secondary)
                if item.date != nil {
                    DateItemView(date: item.date)
                }
            }
            .padding(.leading)
            Spacer()
            Image(systemName: item.done ? "checkmark.circle" : "circle")
                .onTapGesture {
                    withAnimation(.linear) {
                        listItemViewModel.reverseDone(for: item)
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

//#Preview {
//    NavigationView {
//        ListItemView()
//    }
//    .environmentObject(ListItemViewModel())
//}
