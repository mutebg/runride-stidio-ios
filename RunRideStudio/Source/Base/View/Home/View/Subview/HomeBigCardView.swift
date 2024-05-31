//
//  HomeBigCardView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import SwiftUI

struct HomeBigCardView: View {
    var title: String
    var image: ImageResource
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.textBrand1)

                Image(systemName: "arrow.up.right.circle")
                    .foregroundStyle(.textBrand1)
            }
            .padding(16.0)
            
            Spacer()
            
            Image(image)
                .padding([.top, .trailing], 24.0)
        }
        .background(.cardBackground)
        .clipShape(.rect(cornerRadius: 16.0))
    }
}
