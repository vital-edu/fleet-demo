//
//  ShowVehicleViewModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

protocol ShowVehicleViewModelCoordinatorDelegate: AnyObject {
    func show(alert: AlertModel, from controller: UIViewController)
}

protocol ShowVehicleViewModelProtocol: AnyObject {
    var delegate: ShowVehicleViewModelCoordinatorDelegate? { get set }

    // MARK: - Data Source

    var navigationTitle: String { get }
    var positions: Dynamic<[VehiclePositionViewData]> { get }
    var startMarkerTitle: String { get }
    var endMarkerTitle: String { get }
    var bottomTitle: Dynamic<String> { get }

    // MARK: - Events
    func refresh(from viewController: UIViewController)
}

class ShowVehicleViewModel: ShowVehicleViewModelProtocol {
    let vehicle: Vehicle

    var delegate: ShowVehicleViewModelCoordinatorDelegate?
    let service: ShowVehicleServiceProtocol
    let navigationTitle: String
    let positions = Dynamic<[VehiclePositionViewData]>([])
    let startMarkerTitle: String = "Start"
    let endMarkerTitle: String = "End"
    let bottomTitle = Dynamic<String>("Fetching data...")

    init(vehicle: Vehicle, service: ShowVehicleServiceProtocol) {
        self.service = service
        self.vehicle = vehicle
        self.navigationTitle = "Location history: \(vehicle.plate)"
    }

    func refresh(from viewController: UIViewController) {
        let vehicleId = "\(vehicle.objectId)"
        service.getPositionsOf(vehicleId: vehicleId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let alert):
                self.delegate?.show(alert: alert, from: viewController)
            case .success(let positions):
                self.positions.value = positions.map { VehiclePositionViewData(model: $0) }
                let distanceInKm = positions.last?.distance?.doubleByKilo().string(zeroes: 2) ?? "Unknown"
                self.bottomTitle.value = "Trip distance: \(distanceInKm) km"
            }
        }
    }
}
