//
//  NetworkService.swift
//  RandomImageApp
//
//  Created by Виталий Емельянов on 25.11.2021.
//

import Foundation

protocol RandomImageGetable {
    var randomImageUrl: String? { get set }
    func getImage(id: String?, completion: @escaping (Result<ImageInfo?, Error>) -> Void)
}

class NetworkService: RandomImageGetable {
    var randomImageUrl: String?

    static var shared = NetworkService()
    private init (){}
    
    func getImage(id: String? = nil, completion: @escaping (Result<ImageInfo?, Error>) -> Void) {
        //Refactoring
        var urlString = ""
        if let imageId = id {
            let config = UnsplashConfig(photoId: imageId)
            urlString = config.getImageByIdEndpoint
        } else {
            urlString = UnsplashConfig.randomImageEndpoint
        }
        
        guard let url =  URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(ImageInfo.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
