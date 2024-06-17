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

struct Photo: Codable, Identifiable, Equatable {
    let id: String
    let alt_description: String
    let urls: Urls
    let user: User
    var isFavourite: Bool? = false
    
    struct User: Codable, Equatable {
        let username: String
        let name: String
        let bio: String?
        let location: String?
    }
    
    struct Urls: Codable, Equatable {
        let small: URL
        let regular: URL
    }
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id &&
               lhs.alt_description == rhs.alt_description &&
               lhs.urls == rhs.urls &&
               lhs.user == rhs.user &&
               lhs.isFavourite == rhs.isFavourite
    }
}
