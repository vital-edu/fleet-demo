//
//  VehiclesService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

protocol VehiclesServiceProtocol {
    func getVehicles(completion: @escaping ([Vehicle]) -> Void)
}

class VehiclesService: VehiclesServiceProtocol {
    let localDataSource: VehiclesDataSource
    let remoteDataSource: VehiclesDataSource

    init(remoteDataSource: VehiclesDataSource, localDataSource: VehiclesDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func getVehicles(completion: @escaping ([Vehicle]) -> Void) {
        self.remoteDataSource.getAll { result in
            switch result {
            case .failure(let error):
                // TODO: fetch local data
                print(error)
                completion([])
            case .success(let vehicles):
                // TODO: save to local data store
                completion(vehicles)
            }
        }
    }
}
