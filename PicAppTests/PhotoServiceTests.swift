//
//  PhotoServiceTests.swift
//  PicAppTests
//
//  Created by Negin Zahedi on 2024-06-15.
//

import XCTest
import Combine
@testable import PicApp

class PhotoServiceTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    func testFetchPhotosSuccess() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        let service = PhotoService(baseUrl: "https://api.unsplash.com/photos", clientID: "abc123", session: session)
        
        let photos = [
            Photo(id: "1", alt_description: "A beautiful landscape", urls: Photo.Urls(small: URL(string: "https://example.com/small")!, regular: URL(string: "https://example.com/regular")!), user: Photo.User(username: "john_doe", name: "John Doe", bio: "Photographer", location: "USA")),
            Photo(id: "2", alt_description: "bunch of round stones", urls: Photo.Urls(small: URL(string: "https://example.com/small")!, regular: URL(string: "https://example.com/regular")!), user: Photo.User(username: "mac_q", name: "Mac Queen", bio: "Photographer", location: "Italy"))
        ]
        
        let data = try! JSONEncoder().encode(photos)
        let response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/photos")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        MockURLProtocol.mockResponses[URL(string: "https://api.unsplash.com/photos/?client_id=abc123")!] = (data, response, nil)
        
        let expectation = XCTestExpectation(description: "Fetching photos")
        
        service.fetchPhotos()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { receivedPhotos in
                XCTAssertEqual(receivedPhotos, photos)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchPhotosFailure() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        let service = PhotoService(baseUrl: "https://api.unsplash.com/photos", clientID: "test", session: session)
        
        let response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/photos")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        
        MockURLProtocol.mockResponses[URL(string: "https://api.unsplash.com/photos/?client_id=test")!] = (nil, response, nil)
        
        let expectation = XCTestExpectation(description: "Fetching photos with failure")
        
        service.fetchPhotos()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, URLError.badServerResponse)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
