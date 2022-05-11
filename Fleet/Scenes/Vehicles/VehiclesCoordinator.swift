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
        let vehiclesViewData = [
            VehicleViewData(
                leftTitle: "114TUC / Arton Polster",
                rightTitle: "22 hm/h",
                leftSubtitle: "Kostoni 44, Tortu, Estonia",
                rightSubtitle: "1m 22s ago"
            ),
            VehicleViewData(
                leftTitle: "123ABC / Mikoel-Erik Tohmao",
                rightTitle: "-",
                leftSubtitle: "Kostoni 44, Tortu, Estonia",
                rightSubtitle: "2h ago"
            )
        ]
        let viewModel = VehiclesViewModel()
        viewModel.items.value = vehiclesViewData
        viewController.viewModel = viewModel
        rootViewController.setViewControllers([viewController], animated: false)
    }

    override func finish() {

    }
}
