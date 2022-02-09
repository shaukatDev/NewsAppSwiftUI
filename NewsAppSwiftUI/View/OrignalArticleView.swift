//
//  OrignalArticleView.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import SwiftUI
import WebKit

struct OrignalArticleView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}
//
//struct OrignalArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        //OrignalArticleView(request: "")
//    }
//}
