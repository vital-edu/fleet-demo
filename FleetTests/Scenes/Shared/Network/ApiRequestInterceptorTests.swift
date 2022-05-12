//
//  ApiRequestInterceptorTests.swift
//  FleetTests
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import XCTest
import Alamofire
@testable import Fleet

class ApiRequestInterceptorTests: XCTestCase {
    func testAdapt_whenUrlHasParameters_sholdAddRequiedParameters() throws {
        let serviceMock = ApiKeyServiceMock()
        let apiKey = "myApiKey"
        serviceMock.getApiKeyReturnValue = apiKey
        let sut = ApiRequestInterceptor(service: serviceMock)
        let expectation = XCTestExpectation()

        let request = try URLRequest(url: "https://api.dev?arg1=1&arg2=2", method: .get)
        let session = Session()
        sut.adapt(request, for: session) { result in
            switch result {
            case .failure(let error):
                XCTFail("error: \(error.localizedDescription)")
            case .success(let request):
                XCTAssertEqual(request.url?.absoluteString, "https://api.dev?arg1=1&arg2=2&key=\(apiKey)&json=true")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testAdapt_whenUrlHasNoParameters_sholdAddRequiedParameters() throws {
        let serviceMock = ApiKeyServiceMock()
        let apiKey = "myApiKey"
        serviceMock.getApiKeyReturnValue = apiKey
        let sut = ApiRequestInterceptor(service: serviceMock)
        let expectation = XCTestExpectation()

        let request = try URLRequest(url: "https://api.dev", method: .get)
        let session = Session()
        sut.adapt(request, for: session) { result in
            switch result {
            case .failure(let error):
                XCTFail("error: \(error.localizedDescription)")
            case .success(let request):
                XCTAssertEqual(request.url?.absoluteString, "https://api.dev?key=\(apiKey)&json=true")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
