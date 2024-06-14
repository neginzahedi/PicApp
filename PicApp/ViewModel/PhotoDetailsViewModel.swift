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
    }
}
