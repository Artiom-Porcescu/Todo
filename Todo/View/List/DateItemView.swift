//
//  DateItemView.swift
//  Todo
//
//  Created by Artiom Porcescu on 05.02.2025.
//

import SwiftUI

struct DateItemView: View {
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
            Text("10.02.2025")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    DateItemView()
}
