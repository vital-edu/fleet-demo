//
//  ApiKeyService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

protocol ApiKeyServiceProtocol {
    var store: LocalDataStoreProtocol { get }

    func getApiKey(completion: (String?) -> Void)
    func save(apiKey: String)
}

class ApiKeyService: ApiKeyServiceProtocol {
    var store: LocalDataStoreProtocol
    let storeKey = UserDefaultsKey.apiKey.rawValue

    init(store: LocalDataStoreProtocol) {
        self.store = store
    }

    func getApiKey(completion: (String?) -> Void) {
        let apiKey = store.getValue(forKey: storeKey)
        completion(apiKey)
    }

    func save(apiKey: String) {
        store.save(value: apiKey, forKey: storeKey)
    }
}
