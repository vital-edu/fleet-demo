//
//  ApiKeyServiceTests.swift
//  FleetTests
//
//  Created by Eduardo Vital Alencar Cunha on 11/05/2022.
//

import XCTest
@testable import Fleet

class ApiKeyServiceTests: XCTestCase {
    func testGetApiKey_shouldReturnCorrectValue() throws {
        let storeMock = LocalDataStoreMock()
        let expectation = XCTestExpectation()
        let expectedResult = "testValueResult"
        storeMock.store = [
            UserDefaultsKey.apiKey.rawValue: expectedResult
        ]

        let sut = ApiKeyService(store: storeMock)
        sut.getApiKey { apiKey in
            XCTAssertEqual(apiKey, expectedResult)
            XCTAssertEqual(
                storeMock.calls[.getValue],
                [["forKey": UserDefaultsKey.apiKey.rawValue]]
            )
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
