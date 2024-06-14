//
//  PhotosListViewModel.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation
import Combine

/// View model responsible for managing the list of photos displayed in the app
class PhotosListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// Published property exposing the array of photos to observe changes.
    @Published var photos = [Photo]()
    
    private var cancellables = Set<AnyCancellable>()
    private let imageService = PhotoService()
    
    // MARK: - Public Methods
    
    /// Fetches a list of photos from the API using `PhotoService` and updates `photos` upon receiving data.
    func fetchImages() {
        imageService.fetchPhotos()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] photos in
                self?.photos = photos
            })
            .store(in: &cancellables)
    }
}
