//
//  PicAppTests.swift
//  PicAppTests
//
//  Created by Negin Zahedi on 2024-06-14.
//

import XCTest
@testable import PicApp

final class PicAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCapitalizedEachWord() throws {
        // Test empty string
        XCTAssertEqual("".capitalizedEachWord(), "")
        
        // Test multiple word
        XCTAssertEqual("a large group of round white objects".capitalizedEachWord(), "A Large Group Of Round White Objects")
        
        // Test words with different casing
        XCTAssertEqual("a lArge group of roUnd whIte obJects".capitalizedEachWord(), "A LArge Group Of RoUnd WhIte ObJects")
        
        // Test multiple spaces
        XCTAssertEqual("   a large group    of round white objects".capitalizedEachWord(), "   A Large Group    Of Round White Objects")
        
        // Test non alphabetic characters
        XCTAssertEqual("123 round white objects".capitalizedEachWord(), "123 Round White Objects")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = "a large group of round white objects".capitalizedEachWord()
        }
    }

}
