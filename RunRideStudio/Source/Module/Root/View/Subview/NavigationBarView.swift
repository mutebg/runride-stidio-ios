//
//  NavigationBarView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

struct NavigationBarView: View {
    let title: String
    let subtitle: String?
    
    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
            }
        }
    }
}

