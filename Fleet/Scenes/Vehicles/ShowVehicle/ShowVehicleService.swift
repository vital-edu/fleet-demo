//
//  ShowVehicleService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

protocol ShowVehicleServiceProtocol: AnyObject {
    var dataSource: ShowVehicleDataSource { get }
    func getPositionsOf(vehicleId: String, completion: @escaping (Either<[VehiclePosition], AlertModel>) -> Void)
}

class ShowVehicleService: ShowVehicleServiceProtocol {
    let dataSource: ShowVehicleDataSource

    init(dataSource: ShowVehicleDataSource) {
        self.dataSource = dataSource
    }

    func getPositionsOf(vehicleId: String, completion: @escaping (Either<[VehiclePosition], AlertModel>) -> Void) {
        dataSource.getPositionFor(vehicleId: vehicleId) { result in
            switch result {
            case .failure(let error):
                let alert = AlertModel(
                    title: "Error",
                    message: error.localizedDescription,
                    primaryAction: UIAlertAction(title: "OK", style: .cancel)
                )
                completion(.failure(alert))
            case .success(let positions):
                completion(.success(positions))
            }
        }
    }
}
