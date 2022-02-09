//
//  Api.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import Foundation
import Alamofire

protocol Api {
     func getNews(params:String,completion:@escaping (AFResult<News>)->Void)
}


//Api Implementation class
class NewsApi: Api {
    
  
     func getNews(params:String, completion: @escaping (AFResult<News>) -> Void) {
        let decoder = JSONDecoder()
//        let context = CoreDataHelper.sharedInstance.persistentContainer.viewContext
//        decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
        AF.request(Router.GetNews(params))
            .responseDecodable(decoder: decoder) {
                (response: AFDataResponse<News>) in
                debugPrint(response)
                completion(response.result)
        }
        
    }


}



