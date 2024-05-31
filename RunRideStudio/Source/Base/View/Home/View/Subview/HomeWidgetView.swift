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
    
    init(background: Background, @ViewBuilder content: () -> Content) {
        self.background = background
        self.content = content()
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
    }
}

extension HomeWidgetView where Background == Color {
    init(color: Color, @ViewBuilder content: () -> Content) {
        self.init(background: color, content: content)
    }
}
