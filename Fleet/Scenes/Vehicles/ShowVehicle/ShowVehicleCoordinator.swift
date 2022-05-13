//
//  ShowVehicleCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

class ShowVehicleCoordinator: Coordinator {
    weak var rootViewController: UINavigationController?

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    override func start() {
        let viewController = ShowVehicleViewController()
        rootViewController?.pushViewController(viewController, animated: true)
    }
}
