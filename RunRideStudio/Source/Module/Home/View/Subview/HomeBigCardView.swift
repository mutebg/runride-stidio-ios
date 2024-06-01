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
            VStack(alignment: .leading, spacing: Spacing.space8) {
                Text(title)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.textBrand1)

                Image(systemName: "arrow.up.right.circle")
                    .foregroundStyle(.textBrand1)
            }
            .padding(Spacing.space20)
            
            Spacer()
            
            Image(image)
                .padding([.top, .trailing], Spacing.space24)
        }
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 16.0))
    }
}
