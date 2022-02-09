//
//  ArticleDetailView.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import SwiftUI

struct ArticleDetailView: View {
    
    var article : Article
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                if let url = URL(string:article.urlToImage ?? "")
                {
                    NetworkImage(url: url).frame( maxWidth: .infinity)
                }
                
                Text("\(article.title!)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .frame( maxWidth: .infinity, alignment: .leading)
                Text("\(article.articleDescription ?? "")")
                    .font(.body)
                    .frame( maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("\(article.author ?? "")")
                    .font(.body)
                    .frame( maxWidth: .infinity, alignment: .leading)
                
                Text("\(stringToDate(article.publishedAt ?? ""))")
                    .font(.body)
                    .frame( maxWidth: .infinity, alignment: .leading)
                
                if let articleUrl = URL(string:article.url ?? "")
                {
                    if let  urlRequest = URLRequest(url: articleUrl)
                    {
                        NavigationLink(destination: OrignalArticleView(request: urlRequest)) {
                            Spacer()
                            Text("Orignal Article>>")
                        
                        }
                      
                    }
                }
                
            }.frame( maxWidth: .infinity).padding(20)
            
        }
    }
}
//struct ArticleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
