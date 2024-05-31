//
//  HomeSectionHeaderView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import SwiftUI

struct HomeSectionHeaderView: View {
    let title: String
    let onEdit: (() -> Void)?
    
    init(
        title: String,
        onEdit: (() -> Void)? = nil
    ) {
        self.title = title
        self.onEdit = onEdit
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.textBrand1)
                .opacity(0.7)
            
            Spacer()
            
            if let onEdit {
                Button {
                    onEdit()
                } label: {
                    Text("Edit")
                        .font(.subheadline)
                }
            }
        }
    }
}
