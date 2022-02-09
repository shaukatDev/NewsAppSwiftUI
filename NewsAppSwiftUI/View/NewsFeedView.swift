//
//  NewsFeedView.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import SwiftUI

struct NewsFeedView: View {
    
    @ObservedObject var newsVM = NewsViewModel.sharedInstance
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            
            if #available(iOS 14.0, *) {
                List(newsVM.articles) { article in
                    NavigationLink {
                        ArticleDetailView(article:article)
                    } label: {
                        ArticleRow(article:article)
                    }
                }.navigationTitle("News").listStyle(PlainListStyle())
            }
            else
            {
                List(newsVM.articles) { article in
                    NavigationLink {
                        ArticleDetailView(article:article)
                    } label: {
                        ArticleRow(article:article)
                    }
                }.listStyle(PlainListStyle())
            }
            
        }.onAppear {
            //start fetching the news
            NewsApi().getNews(params: "top-headlines?sources=techcrunch") {
                result in
                switch result {
                case .success(let news):
                   
                    newsVM.articles = news.articles
                case .failure(let error):
                    showingAlert = true
                    debugPrint(error.localizedDescription)
                }
                
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Oops!"), message: Text("Could't fetch the news, try again later"), dismissButton: .default(Text("Got it!")))
                   
                }
    }
}



struct ArticleRow: View {
    
    var article : Article
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            if let url = URL(string:article.urlToImage ?? "")
            {
                NetworkImage(url: url).frame( maxWidth: .infinity)
            }
            
            Text("\(article.title!)")
                .font(.title3)
                .padding(.bottom)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            Text("\(article.author ?? "")")
                .font(.body)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            Text("\(stringToDate(article.publishedAt ?? "" ))")
                .font(.body)
                .frame( maxWidth: .infinity, alignment: .leading)
            
        }.frame( maxWidth: .infinity)
        
        
    }
    
}




struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
