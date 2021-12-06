//
//  APIConfig.swift
//  RandomImageApp
//
//  Created by Виталий Емельянов on 25.11.2021.
//

import Foundation

struct UnsplashConfig {
    let photoId:String?
    static let APIKey = "AEh1iVNsGbiiXgDHTQdIFmdbnJLVLC0nKNofh2OQ0Nc"
    static let randomImageEndpoint = "https://api.unsplash.com/photos/random/?client_id=\(APIKey)"
    var getImageByIdEndpoint: String {
        return "https://api.unsplash.com/photos/\(photoId ?? "1")/?client_id=\(UnsplashConfig.APIKey)"
    }
}
