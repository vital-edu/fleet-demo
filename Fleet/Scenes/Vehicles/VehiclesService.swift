//
//  VehiclesService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

protocol VehiclesServiceProtocol {
    func getVehicles(completion: @escaping (Either<[Vehicle], AlertModel>) -> Void)
}

class VehiclesService: VehiclesServiceProtocol {
    let localDataSource: VehiclesDataSource
    let remoteDataSource: VehiclesDataSource

    init(remoteDataSource: VehiclesDataSource, localDataSource: VehiclesDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func getVehicles(completion: @escaping (Either<[Vehicle], AlertModel>) -> Void) {
        self.remoteDataSource.getAll { result in
            switch result {
            case .failure(let error):
                // TODO: fetch local data
                let alert = AlertModel(
                    title: "Error",
                    message: error.localizedDescription,
                    primaryAction: UIAlertAction(title: "OK", style: .cancel)
                )
                completion(.failure(alert))
            case .success(let vehicles):
                // TODO: save to local data store
                completion(.success(vehicles))
            }
        }
    }
}
