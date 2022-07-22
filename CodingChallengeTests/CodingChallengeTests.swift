//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by on 07/21/22.
//

import XCTest
@testable import CodingChallenge

class CodingChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchAcronymsAPI(){
        let searchWord = "ABB"
        let urlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(searchWord)"
        let URL = NSURL(string: urlString)!
        let expectation = expectation(description: "GET \(URL)")
        NetworkManager.sharedInstance.requestWithModel(urlString: urlString, method: .GET, model: Acronyms.self) { response in
            XCTAssert(response.statusCode == 200, response.message)
            XCTAssert((response.model?.first?.lfs?.count ?? 0) > 0, "No results found")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
