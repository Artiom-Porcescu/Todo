//
//  DateItemView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct DateItemView: View {
    
    let date: Date?
    
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
            if let date {
                Text(date.formatted(.dateTime
                    .day()
                    .month(.twoDigits)
                    .year()
                    .hour()
                    .minute()
                    )
                )
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}

//#Preview {
//    DateItemView()
//}
