//
//  VehiclesViewModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 10/05/2022.
//

import Foundation
import UIKit

protocol VehiclesViewModelCoordinatorDelegate: AnyObject {
    func didSelect(vehicle: VehicleViewData, from controller: UIViewController)
    func didSelectApiKey(from controller: UIViewController)
    func show(alert: AlertModel, from controller: UIViewController)
}

protocol VehiclesViewModelProtocol {
    var delegate: VehiclesViewModelCoordinatorDelegate? { get set }

    // MARK: - Data Source

    var navigationTitle: String { get }
    var items: Dynamic<[VehicleViewData]> { get set }

    // MARK: - Events

    func didSelect(row: Int, from controller: UIViewController)
    func refresh(from controller: UIViewController)
    func changeApiKey(from controller: UIViewController)
}

class VehiclesViewModel: VehiclesViewModelProtocol {
    weak var delegate: VehiclesViewModelCoordinatorDelegate?
    var navigationTitle: String = "Vehicles"
    var items: Dynamic<[VehicleViewData]> = Dynamic([])
    let service: VehiclesServiceProtocol

    init(service: VehiclesServiceProtocol) {
        self.service = service
    }

    func didSelect(row: Int, from controller: UIViewController) {
        print("selected vehicle \(items.value[row].leftTitle)")
    }

    func refresh(from controller: UIViewController) {
        service.getVehicles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let vehicles):
                self.items.value = vehicles.map { VehicleViewData(model: $0) }
            case .failure(let alert):
                self.delegate?.show(alert: alert, from: controller)
            }
        }
    }

    func changeApiKey(from controller: UIViewController) {
        delegate?.didSelectApiKey(from: controller)
    }
}
