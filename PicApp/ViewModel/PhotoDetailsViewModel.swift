//
//  PhotoDetailsViewModel.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation

class PhotoDetailsViewModel: ObservableObject {
    
    @Published var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        self.photo.isFavourite = FavoritePhotosPersistenceManager.shared.isFavorite(id: photo.id)
    }
    
    func toggleFavourite() {
        photo.isFavourite?.toggle()
        FavoritePhotosPersistenceManager.shared.toggleFavorite(id: photo.id)
    }
}
