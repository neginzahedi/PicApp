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
    private let baseUrl: String
    private let clientID: String
    private let session: URLSession
    
    private let logger = Logger(subsystem: Config.loggerSubsystem, category: "PhotoService")
    
    init(baseUrl: String = Config.unsplashBaseUrl, clientID: String = Config.unsplashClientID, session: URLSession = .shared) {
        self.baseUrl = baseUrl
        self.clientID = clientID
        self.session = session
    }
    
    // MARK: - Public Methods
    
    func fetchPhotos() -> AnyPublisher<[Photo], Error> {
        guard let url = URL(string: "\(baseUrl)/?client_id=\(clientID)") else {
            fatalError("Invalid URL")
        }
        
        //logger.debug("Fetching images from URL: \(url)")
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                //self.logger.debug("HTTP Status Code: \(httpResponse.statusCode)")
                guard httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //self.logger.debug("Received raw data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                return data
            }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .map { response in
                //self.logger.debug("Decoded response: \(response)")
                return response
            }
            .receive(on: DispatchQueue.main)
            .mapError { error -> Error in
                //self.logger.error("Error occurred: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
