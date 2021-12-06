//
//  SingleImage.swift
//  RandomImageApp
//
//  Created by Виталий Емельянов on 25.11.2021.
//

import Foundation

struct ImageInfo: Codable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let urls: ImageUrls
    let user: ImageOwnerInfo
}

