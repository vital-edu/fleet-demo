//
//  Coordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 08/05/2022.
//

import Foundation

class Coordinator {
    private(set) var childCoordinators = [Coordinator]()

    func start() {
        assertionFailure("This method needs to be overriden by concrete subclass.")
    }

    func finish() {
        assertionFailure("This method needs to be overriden by concrete subclass.")
    }

    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else {
            // TODO: register error in logging service
            return
        }
        childCoordinators.remove(at: index)
    }

    func removeAllChildren<T: Coordinator>(of type: T) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }

    func removeAllChildren() {
        childCoordinators.removeAll()
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
