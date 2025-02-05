//
//  MainCreationView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct MainCreationView: View {
    
    @State var title = ""
    @State var desc = ""
    
    var body: some View {
        VStack {
            CreationImageView()
            VStack {
                TextField("Заголовок", text: $title, axis: .horizontal)
                    .padding()
                    .border(.secondary, width: 1)
                    .padding()
                TextField("Описание", text: $desc, axis: .vertical)
                    .frame(height: 200)
                    .padding()
                    .border(.secondary, width: 1)
                    .padding()
            }
            NotificationButtonView(title: "Добавить напоминание")
            NotificationButtonView(title: "Удалить", color: .black, background: .secondary)
            
        }
    }
}

#Preview {
    MainCreationView()
}
