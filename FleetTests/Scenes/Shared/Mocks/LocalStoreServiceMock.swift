//
//  LocalStoreServiceMock.swift
//  FleetTests
//
//  Created by Eduardo Vital Alencar Cunha on 11/05/2022.
//

import Foundation
@testable import Fleet

class LocalStoreServiceMock: LocalStoreServiceProtocol {
    enum Method { case save, deleteValue, getValue }
    var store = [String: String]()
    private(set) var calls = [Method: [[String: String]]]()

    init(store: [String: String] = [:]) {
        self.store = store
        reset()
    }

    func save(value: String, forKey key: String) {
        calls[.save]?.append(["value": value, "forKey": key])
        store[key] = value
    }

    func deleteValue(forKey key: String) {
        calls[.deleteValue]?.append(["forKey": key])
        store.removeValue(forKey: key)
    }

    func getValue(forKey key: String) -> String? {
        calls[.getValue]?.append(["forKey": key])
        return store[key]
    }

    func reset() {
        store = [:]
        calls = [
            .getValue: [],
            .deleteValue: [],
            .save: []
        ]
    }
}
