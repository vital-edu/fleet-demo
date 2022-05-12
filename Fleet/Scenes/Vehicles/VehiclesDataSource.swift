//
//  VehiclesDataSource.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

protocol VehiclesDataSource {
    func save(value: [Vehicle])
    func deleteAll()
    func getAll(completion: ([Vehicle]) -> Void)
}

class VehiclesLocalDataSource: VehiclesDataSource {
    let store: UserDefaults
    let key = UserDefaultsKey.vehicles.rawValue

    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
    }

    func save(value: [Vehicle]) {
        store.set(value, forKey: key)
    }

    func deleteAll() {
        store.removeObject(forKey: key)
    }

    func getAll(completion: ([Vehicle]) -> Void) {
        let vehicles = store.object(forKey: key) as? [Vehicle] ?? []
        completion(vehicles)
    }
}

class VehiclesRemoteDataSource: VehiclesDataSource {
    func save(value: [Vehicle]) {
        // TODO: Implement
    }

    func deleteAll() {
        // TODO: Implement
    }

    func getAll(completion: ([Vehicle]) -> Void) {
        // TODO: Implement
    }
}
