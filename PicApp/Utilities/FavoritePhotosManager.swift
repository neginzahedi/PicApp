//
//  FavoritePhotosManager.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation

/// Singleton class to manage favorite photos using JSON file for persistence.
class FavoritePhotosPersistenceManager{
    
    // MARK: - Properties
    
    private let favoritesFileName = "favorite.json"
    
    static let shared = FavoritePhotosPersistenceManager()
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    /// Returns the URL for the favorites JSON file in the documents directory.
    /// - Returns: URL for the favorites JSON file.
    func getFavoritesFileURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent(favoritesFileName)
    }
    
    /// Loads favorite photo IDs from the JSON file.
    /// - Returns: Array of favorite photo IDs.
    func loadFavorites() -> [String] {
        guard let fileURL = getFavoritesFileURL(),
              let data = try? Data(contentsOf: fileURL),
              let favoriteIDs = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return favoriteIDs
    }
    
    /// Saves favorite photo IDs to the JSON file.
    /// - Parameter favoriteIDs: Array of favorite photo IDs to be saved.
    func saveFavorites(_ favoriteIDs: [String]) {
        guard let fileURL = getFavoritesFileURL() else { return }
        if let data = try? JSONEncoder().encode(favoriteIDs) {
            try? data.write(to: fileURL)
        }
    }
    
    /// Checks if a photo is marked as favorite.
    /// - Parameter id: Photo ID to check.
    /// - Returns: Boolean indicating whether the photo is favorite.
    func isFavorite(id: String) -> Bool {
        return loadFavorites().contains(id)
    }
    
    /// Toggles the favorite status of a photo.
    /// - Parameter id: Photo ID to toggle.
    func toggleFavorite(id: String) {
        var favorites = loadFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
        } else {
            favorites.append(id)
        }
        saveFavorites(favorites)
    }
}
