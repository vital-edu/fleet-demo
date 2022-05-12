//
//  ApiKeyServiceMock.swift
//  FleetTests
//
//  Created by Eduardo Vital Alencar Cunha on 11/05/2022.
//

import Foundation
@testable import Fleet

class ApiKeyServiceMock: ApiKeyServiceProtocol {
    enum Method { case save, getApiKey }
    private(set) var calls = [Method: [[String: String]]]()

    var store: LocalDataStoreProtocol = LocalDataStoreMock()
    var getApiKeyReturnValue: String?

    init() {
        reset()
    }

    func getApiKey(completion: (String?) -> Void) {
        calls[.getApiKey]?.append(["completion": "object"])
        completion(getApiKeyReturnValue)
    }

    func save(apiKey: String) {
        calls[.save]?.append(["apiKey": apiKey])
    }

    func reset() {
        store = LocalDataStoreMock()
        calls = [
            .getApiKey: [],
            .save: [],
        ]
        getApiKeyReturnValue = nil
    }
}
