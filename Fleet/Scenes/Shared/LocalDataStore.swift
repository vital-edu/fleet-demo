//
//  LocalStoreService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

protocol LocalDataStoreProtocol {
    func save(value: String, forKey key: String)
    func deleteValue(forKey key: String)
    func getValue(forKey key: String) -> String?
}

class LocalDataStore: LocalDataStoreProtocol {
    let store: UserDefaults

    init(store: UserDefaults = .standard) {
        self.store = store
    }

    func save(value: String, forKey key: String) {
        store.set(value, forKey: key)
    }

    func deleteValue(forKey key: String) {
        store.removeObject(forKey: key)
    }

    func getValue(forKey key: String) -> String? {
        return store.string(forKey: key)
    }
}
