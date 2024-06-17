//
//  FavoritePhotosPersistenceManagerTests.swift
//  PicAppTests
//
//  Created by Negin Zahedi on 2024-06-17.
//

import XCTest
@testable import PicApp

final class FavoritePhotosPersistenceManagerTests: XCTestCase {
    
    // MARK: - Test Lifecycle
    
    override func setUpWithError() throws {
        super.setUp()
        resetFavoritesFile()
    }
    
    override func tearDownWithError() throws {
        resetFavoritesFile()
        super.tearDown()
    }
    
    // MARK: - Helper Methods
    /// Helper method to reset the favorites JSON file before each test.
    func resetFavoritesFile() {
        guard let fileURL = FavoritePhotosPersistenceManager.shared.getFavoritesFileURL() else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {}
    }
    
    // MARK: - Tests
    
    /// Tests saving and loading favorite photo IDs to/from the JSON file.
    func testSaveAndLoadFavorites() {
        // Given
        let manager = FavoritePhotosPersistenceManager.shared
        let favoriteIDs = ["photo1", "photo2", "photo3"]
        
        // When
        manager.saveFavorites(favoriteIDs)
        let loadedFavorites = manager.loadFavorites()
        
        // Then
        XCTAssertEqual(loadedFavorites, favoriteIDs, "Loaded favorites should match saved favorites")
    }
    
    /// Tests toggling the favorite status of photo IDs.
    func testToggleFavorite() {
        // Given
        let manager = FavoritePhotosPersistenceManager.shared
        let id1 = "photo1"
        
        // When
        manager.toggleFavorite(id: id1)
        let favoritesAfterFirstToggle = manager.loadFavorites()
        
        manager.toggleFavorite(id: id1)
        let favoritesAfterSecondToggle = manager.loadFavorites()
        
        // Then
        XCTAssertTrue(favoritesAfterFirstToggle.contains(id1), "Photo1 should be marked as favorite after first toggle")
        XCTAssertFalse(favoritesAfterSecondToggle.contains(id1), "Photo1 should not be marked as favorite after second toggle")
    }
    
    /// Tests checking if a photo ID is marked as favorite.
    func testIsFavorite() {
        // Given
        let manager = FavoritePhotosPersistenceManager.shared
        let photoID1 = "photo1"
        let photoID2 = "photo2"
        
        // When
        manager.toggleFavorite(id: photoID1)
        
        // Then
        XCTAssertTrue(manager.isFavorite(id: photoID1), "Photo1 should be marked as favorite")
        XCTAssertFalse(manager.isFavorite(id: photoID2), "Photo2 should not be marked as favorite")
    }
}
