//
//  PhotoResponseModel.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation

struct PhotoResponse: Codable {
    let results: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: String
    let alt_description: String
    let urls: Urls
    let user: User
    var isFavourite: Bool? = false
    
    struct User: Codable {
        let username: String
        let name: String
        let bio: String?
        let location: String?
    }
    
    struct Urls: Codable {
        let small: URL
        let regular: URL
    }
}
