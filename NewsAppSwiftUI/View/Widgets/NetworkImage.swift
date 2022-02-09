//
//  NetworkImage.swift
//  NewsAppSwiftUI
//
//  Created by s ali on 09/02/22.
//

import SwiftUI
import Combine
import AlamofireImage

let imageDownloader = ImageDownloader(
    configuration: ImageDownloader.defaultURLSessionConfiguration(),
    downloadPrioritization: .fifo,
    maximumActiveDownloads: 4,
    imageCache: AutoPurgingImageCache()
)

extension ImageDownloader {
    func image(for url: URL) -> Future<UIImage?, Error> {
        return Future { subscriber in
           let urlRequest = URLRequest(url: url)
            imageDownloader.download(urlRequest, completion:  { response in
                if case .success(let image) = response.result {
                    subscriber(.success(image))
                }
                else
                {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image downlaod Failed!"])
                    subscriber(.failure(error))
                }
            })
            
            
        }
        
    }
}
var observers: [AnyCancellable] = []
struct NetworkImage: View {

    let url: URL

    init(url: URL) {
        debugPrint(url)
        self.url = url
    }
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if image != nil {
                Image(uiImage: image!).resizable().frame(height:200).aspectRatio(contentMode: .fit)
            } else {
                
                Image(uiImage: UIImage())
            }
        }
        .onAppear(){
            imageDownloader.image(for: url).sink(receiveCompletion: { error in
                debugPrint(error)
            }, receiveValue: { _image in
                self.image = _image
            }).store(in: &observers)
           
        }
    }
}
