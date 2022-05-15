//
//  VehiclesViewModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 10/05/2022.
//

import Foundation
import UIKit

protocol VehiclesViewModelCoordinatorDelegate: AnyObject {
    func didSelect(vehicle: Vehicle, from controller: UIViewController)
    func didSelectApiKey(from controller: UIViewController, completion: @escaping (_ hasApiChanged: Bool) -> Void)
    func show(alert: AlertModel, from controller: UIViewController)
}

protocol VehiclesViewModelProtocol {
    var delegate: VehiclesViewModelCoordinatorDelegate? { get set }

    // MARK: - Data Source

    var navigationTitle: String { get }
    var items: Dynamic<[VehicleViewData]> { get set }

    // MARK: - Events

    func didSelect(row: Int, from controller: BaseViewController)
    func refresh(from controller: BaseViewController)
    func changeApiKey(from controller: BaseViewController)
}

class VehiclesViewModel: VehiclesViewModelProtocol {
    weak var delegate: VehiclesViewModelCoordinatorDelegate?
    var navigationTitle: String = "Vehicles"
    var items: Dynamic<[VehicleViewData]> = Dynamic([])
    let service: VehiclesServiceProtocol

    private var vehicles: [Vehicle] = [] {
        didSet {
            items.value = vehicles.map { VehicleViewData(model: $0) }
        }
    }

    init(service: VehiclesServiceProtocol) {
        self.service = service
    }

    func didSelect(row: Int, from controller: BaseViewController) {
        delegate?.didSelect(vehicle: vehicles[row], from: controller)
    }

    func refresh(from controller: BaseViewController) {
        controller.setLoading(show: true)
        service.getVehicles { [weak self] result in
            guard let self = self else { return }
            controller.setLoading(show: false)
            switch result {
            case .success(let vehicles):
                self.vehicles = vehicles
            case .failure(let alert):
                self.delegate?.show(alert: alert, from: controller)
            }
        }
    }

    func changeApiKey(from controller: BaseViewController) {
        delegate?.didSelectApiKey(from: controller) { [weak self] success in
            if success {
                self?.refresh(from: controller)
            }
        }
    }
}
