//
//  WebView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 11.06.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    private let webView: WKWebView
    private let url: URL?
    
    init(urlPath: String) {
        self.webView = WKWebView(frame: .zero)
        self.url = URL(string: urlPath)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = true
        
        if let url {
            webView.load(URLRequest(url: url))
        }
        
        return webView
        
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
