//
//  SearchField.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 11/02/2026.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Rechercher", text: $searchText)
            if !searchText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        searchText = ""
                    }
                    .foregroundStyle(.gray)
            }
        }
        .padding(5)
        .background {
            Capsule()
                .fill(.gray.opacity(0.2))
        }
        .padding(.bottom)
    }
}

#Preview {
    SearchField(searchText: .constant("test"))
}
