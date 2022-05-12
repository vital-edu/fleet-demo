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
}

protocol VehiclesViewModelProtocol {
    var delegate: VehiclesViewModelCoordinatorDelegate? { get set }

    // MARK: - Data Source

    var navigationTitle: String { get }
    var items: Dynamic<[VehicleViewData]> { get set }

    // MARK: - Events

    func didSelect(row: Int, from controller: UIViewController)
    func refresh()
    func changeApiKey(from controller: UIViewController)
}

class VehiclesViewModel: VehiclesViewModelProtocol {
    weak var delegate: VehiclesViewModelCoordinatorDelegate?
    var navigationTitle: String = "Vehicles"
    var items: Dynamic<[VehicleViewData]> = Dynamic([])

    func didSelect(row: Int, from controller: UIViewController) {
        print("selected vehicle \(items.value[row].leftTitle)")
    }

    func refresh() {
        print("refresh clicked")
        items.value = [items.value[0]]
    }

    func changeApiKey(from controller: UIViewController) {
        delegate?.didSelectApiKey(from: controller)
    }
}
