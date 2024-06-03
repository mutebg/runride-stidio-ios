//
//  View+Extension.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 03.06.2024.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
