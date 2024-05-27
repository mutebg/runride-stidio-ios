//
//  StravaAuthView.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI
import SafariServices

struct StravaAuthView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let authURL = URL(string: "https://api-izq36taffa-uc.a.run.app/login?platform=ios");
        return SFSafariViewController(url: authURL!)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Not needed for basic setup
    }
}
