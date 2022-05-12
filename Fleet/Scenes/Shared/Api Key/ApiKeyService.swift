//
//  ApiKeyService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

protocol ApiKeyServiceProtocol {
    var store: LocalStoreServiceProtocol { get }

    func getApiKey(completion: (String?) -> Void)
}

class ApiKeyService: ApiKeyServiceProtocol {
    var store: LocalStoreServiceProtocol
    let storeKey = "ApiKey"

    init(store: LocalStoreServiceProtocol) {
        self.store = store
    }

    func getApiKey(completion: (String?) -> Void) {
        let apiKey = store.getValue(forKey: storeKey)
        completion(apiKey)
    }
}
