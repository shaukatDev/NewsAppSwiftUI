//
//  NewsViewModel.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import Foundation

class NewsViewModel: ObservableObject{
    @Published var articles = [Article]()
    static let  sharedInstance = NewsViewModel()
   
}
