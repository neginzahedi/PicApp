//
//  PhotosService.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation
import Combine
import os.log

/// Service class responsible for fetching photos from the Unsplash API.
class PhotoService {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private let baseUrl = "https://api.unsplash.com/photos"
    private let clientID = Config.unsplashClientID
    
    private let logger = Logger(subsystem: "com.neginzahedi.PicApp", category: "PhotoService")
    
    // MARK: - Public Methods
    
    /// Fetches a list of photos from the Unsplash API.
    /// - Returns: A publisher that emits an array of `Photo` objects or an error.
    func fetchPhotos() -> AnyPublisher<[Photo], Error> {
        guard let url = URL(string: "\(baseUrl)/?client_id=\(clientID)") else {
            fatalError("Invalid URL")
        }
        
        logger.debug("Fetching images from URL: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                self.logger.debug("HTTP Status Code: \(httpResponse.statusCode)")
                guard httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                self.logger.debug("Received raw data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                return data
            }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .map { response in
                self.logger.debug("Decoded response: \(response)")
                return response
            }
            .receive(on: DispatchQueue.main)
            .mapError { error -> Error in
                self.logger.error("Error occurred: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
