//
//  VehiclesViewModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 10/05/2022.
//

import Foundation
import UIKit

protocol VehiclesViewModelProtocol {
    // MARK: - Data Source

    var navigationTitle: String { get }
    var items: Dynamic<[VehicleViewData]> { get set }

    // MARK: - Events

    func didSelect(row: Int, from controller: UIViewController)
    func refresh()
    func changeApiKey()
}

class VehiclesViewModel: VehiclesViewModelProtocol {
    var navigationTitle: String = "Vehicles"

    var items: Dynamic<[VehicleViewData]> = Dynamic([])

    func didSelect(row: Int, from controller: UIViewController) {
        print("selected vehicle \(items.value[row].leftTitle)")
    }

    func refresh() {
        print("refresh clicked")
        items.value = [items.value[0]]
    }

    func changeApiKey() {
        print("change API Key clicked")
    }
}
