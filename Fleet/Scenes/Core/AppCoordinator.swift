//
//  AppCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 08/05/2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow?

    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        let service = ApiKeyService(store: LocalDataStore())
        let apiClient = ApiClient(service: service)
        let vehicleCoordinator = VehiclesCoordinator(
            rootViewController: rootViewController,
            apiClient: apiClient
        )
        addChild(vehicleCoordinator)
        vehicleCoordinator.start()
    }
}
