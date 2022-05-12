//
//  VehiclesService.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

protocol VehiclesServiceProtocol {
    func getVehicles(completion: ([Vehicle]) -> Void)
}

class VehiclesService: VehiclesServiceProtocol {
    func getVehicles(completion: ([Vehicle]) -> Void) {
        // TODO: implement
    }
}
