//
//  VehiclesCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation
import UIKit

class VehiclesCoordinator: Coordinator {
    weak var rootViewController: UINavigationController?
    let apiClient: ApiClient

    init(rootViewController: UINavigationController, apiClient: ApiClient) {
        self.rootViewController = rootViewController
        self.apiClient = apiClient
    }

    override func start() {
        let viewController = VehiclesViewController()
        let service = VehiclesService(
            remoteDataSource: VehiclesRemoteDataSource(apiClient: apiClient),
            localDataSource: VehiclesLocalDataSource()
        )
        let viewModel = VehiclesViewModel(service: service)
        viewModel.delegate = self
        viewController.viewModel = viewModel
        rootViewController?.setViewControllers([viewController], animated: false)
    }

    override func finish() {

    }
}

extension VehiclesCoordinator: VehiclesViewModelCoordinatorDelegate {
    func didSelect(vehicle: Vehicle, from controller: UIViewController) {
        guard let rootViewController = rootViewController else { return }
        let coordinator = ShowVehicleCoordinator(vehicle: vehicle, rootViewController: rootViewController, apiClient: apiClient)
        addChild(coordinator)
        coordinator.start()
    }

    func didSelectApiKey(from controller: UIViewController, completion: @escaping (_ hasApiChanged: Bool) -> Void) {
        guard let rootViewController = rootViewController else { return }
        let coordinator = ApiKeyCoordinator(rootViewController: rootViewController, delegate: self, completion: completion)
        addChild(coordinator)
        coordinator.start()
    }

    func show(alert: AlertModel, from controller: UIViewController) {
        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        alertController.addAction(alert.primaryAction)
        if let secondaryAction = alert.secondaryAction {
            alertController.addAction(secondaryAction)
        }
        controller.present(alertController, animated: true)
    }
}

extension VehiclesCoordinator: ApiKeyCoordinatorDelegate {
    func didFinish(from coordinator: ApiKeyCoordinator) {
        removeChild(coordinator)
    }
}
