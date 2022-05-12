//
//  ApiKeyViewModelTests.swift
//  FleetTests
//
//  Created by Eduardo Vital Alencar Cunha on 11/05/2022.
//

import XCTest
@testable import Fleet

class ApiKeyViewModelTests: XCTestCase {
    func testSaveApiKey_shouldCallSaveInService() {
        let serviceMock = ApiKeyServiceMock()
        let sut = ApiKeyViewModel(service: serviceMock)

        sut.saveApiKey("my_test_api_key")
        XCTAssertEqual(serviceMock.calls[.save], [["apiKey": "my_test_api_key"]])
    }

    func testInit_shouldGetApiKeyFromTheService() {
        let serviceMock = ApiKeyServiceMock()
        let expectedApiKey = "my_return_value_in_test"
        serviceMock.getApiKeyReturnValue = expectedApiKey

        let sut = ApiKeyViewModel(service: serviceMock)
        XCTAssertEqual(sut.apiKey.value, expectedApiKey)
        XCTAssertEqual(serviceMock.calls[.getApiKey], [["completion": "object"]])
    }
}
