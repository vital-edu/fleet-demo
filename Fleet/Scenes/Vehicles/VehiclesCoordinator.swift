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

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    override func start() {
        let viewController = VehiclesViewController()
        rootViewController.setViewControllers([viewController], animated: false)
    }

    override func finish() {

    }
}
