//
//  ImageCache.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100 // Adjust the cache limit as needed
    }
    
    func getImage(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func setImage(_ image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    func removeAllImages() {
        cache.removeAllObjects()
    }
}
