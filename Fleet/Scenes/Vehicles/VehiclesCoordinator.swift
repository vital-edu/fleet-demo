//
//  VehiclesCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation
import UIKit

class VehiclesCoordinator: Coordinator {
    let rootViewController: UINavigationController
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
        rootViewController.setViewControllers([viewController], animated: false)
    }

    override func finish() {

    }
}

extension VehiclesCoordinator: VehiclesViewModelCoordinatorDelegate {
    func didSelect(vehicle: VehicleViewData, from controller: UIViewController) {
        // TODO: create next scene
    }

    func didSelectApiKey(from controller: UIViewController) {
        let store = LocalDataStore()
        let service = ApiKeyService(store: store)
        let viewModel = ApiKeyViewModel(service: service)
        let apiKeyController = ApiKeyController(viewModel: viewModel)
        apiKeyController.present(from: controller)
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
