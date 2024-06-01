//
//  HomeWidgetView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import SwiftUI

struct HomeWidgetView<Content: View, Background: View>: View {
    let content: Content
    let background: Background
    let onEdit: () -> Void
    let onDestroy: () -> Void
    
    init(
        background: Background,
        @ViewBuilder content: () -> Content,
        onEdit: @escaping () -> Void,
        onDestroy: @escaping () -> Void
    ) {
        self.background = background
        self.content = content()
        self.onEdit = onEdit
        self.onDestroy = onDestroy
    }
    
    var body: some View {
        VStack(alignment: .leading) { content }
            .padding()
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .background(background)
            .clipShape(.rect(cornerRadius: 22))
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 22))
            .foregroundColor(.white)
            .contextMenu {
                Button() {
                    onEdit()
                } label: {
                    Label("Customize", systemImage: "pencil")
                }

                Button(role: .destructive) {
                    onDestroy()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}

extension HomeWidgetView where Background == Color {
    init(
        color: Color = .cardBackground,
        @ViewBuilder content: () -> Content,
        onEdit: @escaping () -> Void,
        onDestroy: @escaping () -> Void
    ) {
        self.init(
            background: color,
            content: content,
            onEdit: onEdit,
            onDestroy: onDestroy
        )
    }
}
