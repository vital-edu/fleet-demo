//
//  ShowVehicleService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

protocol ShowVehicleServiceProtocol {
    func getVehicles(completion: @escaping (Either<[Vehicle], AlertModel>) -> Void)
}
class ShowVehicleService {

}
