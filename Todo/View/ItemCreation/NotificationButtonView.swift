//
//  NotificationButtonView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct NotificationButtonView: View {
    
    var title: String = ""
    var color: Color = .white
    var background: Color = .blue
    
    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .bold()
                .padding()
                .foregroundStyle(color)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(background)
                .clipShape(Capsule())
                
        }

    }
}

#Preview {
    NotificationButtonView()
}
