//
//  StringExtensionTests.swift
//  PicAppTests
//
//  Created by Negin Zahedi on 2024-06-17.
//

import XCTest
@testable import PicApp

final class StringExtensionTests: XCTestCase {
    
    // MARK: - Test Lifecycle
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    // MARK: - String Extension Tests
    
    /// Tests the `capitalizedEachWord` extension method with various input strings.
    func testCapitalizedEachWord() throws {
        // Test empty string
        XCTAssertEqual("".capitalizedEachWord(), "")
        
        // Test multiple word
        XCTAssertEqual("round white objects".capitalizedEachWord(), "Round White Objects")
        
        // Test words with different casing
        XCTAssertEqual("roUnd whIte obJects".capitalizedEachWord(), "RoUnd WhIte ObJects")
        
        // Test multiple spaces
        XCTAssertEqual("   round white objects   ".capitalizedEachWord(), "   Round White Objects   ")
        
        // Test non alphabetic characters
        XCTAssertEqual("123 round white objects".capitalizedEachWord(), "123 Round White Objects")
    }
}
