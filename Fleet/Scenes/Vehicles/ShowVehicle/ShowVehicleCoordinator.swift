//
//  ShowVehicleCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

class ShowVehicleCoordinator: Coordinator {

    private weak var rootViewController: UINavigationController?
    private weak var apiClient: ApiClient?
    private let vehicle: Vehicle

    init(vehicle: Vehicle, rootViewController: UINavigationController, apiClient: ApiClient) {
        self.vehicle = vehicle
        self.rootViewController = rootViewController
        self.apiClient = apiClient
    }

    override func start() {
        guard let apiClient = apiClient else { return }
        let dataSource = ShowVehicleRemoteDataSource(apiClient: apiClient)
        let service = ShowVehicleService(dataSource: dataSource)
        let viewModel = ShowVehicleViewModel(vehicle: vehicle, service: service)
        viewModel.delegate = self
        let viewController = ShowVehicleViewController()
        viewController.viewModel = viewModel
        rootViewController?.pushViewController(viewController, animated: true)
    }
}

extension ShowVehicleCoordinator: ShowVehicleViewModelCoordinatorDelegate {
    func show(alert: AlertModel, from controller: UIViewController) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(alert.primaryAction)

        if let secondaryAction = alert.secondaryAction {
            alertController.addAction(secondaryAction)
        }
        controller.present(alertController, animated: true)
    }
}
