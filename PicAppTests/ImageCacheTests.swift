//
//  ImageCacheTests.swift
//  PicAppTests
//
//  Created by Negin Zahedi on 2024-06-17.
//

import XCTest
@testable import PicApp

final class ImageCacheTests: XCTestCase {
    
    // MARK: - Setup and Teardown
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    // MARK: - Test Methods
    
    /// Tests setting and getting an image from the cache.
    func testSetImageAndGetImage() {
        // Given
        let imageCache = ImageCache.shared
        let key = "imageID" as NSString
        let image = UIImage(systemName: "star")!
        
        // When
        imageCache.setImage(image, forKey: key)
        let cachedImage = imageCache.getImage(forKey: key)
        
        // Then
        XCTAssertNotNil(cachedImage, "Faild to cache image")
        XCTAssertEqual(cachedImage, image, "Cached image should match the original image")
    }
    
    /// Tests overwriting an image in the cache.
    func testOverwriteImage() {
        // Given
        let imageCache = ImageCache.shared
        let key = "imageID" as NSString
        let originalImage = UIImage(systemName: "star")!
        let newImage = UIImage(systemName: "heart")!
        
        // When
        imageCache.setImage(originalImage, forKey: key)
        imageCache.setImage(newImage, forKey: key)
        let cachedImage = imageCache.getImage(forKey: key)
        
        // Then
        XCTAssertNotNil(cachedImage, "Failed to cache image for key '\(key)'")
        XCTAssertEqual(cachedImage, newImage, "Expected cached image to be updated to the new image")
    }
    
    /// Tests removing all images from the cache.
    func testRemoveAllImages() {
        // Given
        let imageCache = ImageCache.shared
        let key1 = "imageID1" as NSString
        let key2 = "imageID2" as NSString
        let image1 = UIImage(systemName: "star")!
        let image2 = UIImage(systemName: "heart")!
        
        // When
        imageCache.setImage(image1, forKey: key1)
        imageCache.setImage(image2, forKey: key2)
        imageCache.removeAllImages()
        let cachedImage1 = imageCache.getImage(forKey: key1)
        let cachedImage2 = imageCache.getImage(forKey: key2)
        
        // Then
        XCTAssertNil(cachedImage1, "Expected no image found for key \(key1) after removeAllImages()")
        XCTAssertNil(cachedImage2, "Expected no image found for key \(key2) after removeAllImages()")
    }
    
}
