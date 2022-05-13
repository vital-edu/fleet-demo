//
//  ApiKeyCoordinator.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 13/05/2022.
//

import UIKit

protocol ApiKeyCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: ApiKeyCoordinator)
}

class ApiKeyCoordinator: Coordinator {
    weak var rootViewController: UINavigationController?
    weak var delegate: ApiKeyCoordinatorDelegate?
    let completion: (_ hasApiChanged: Bool) -> Void

    init(rootViewController: UINavigationController, delegate: ApiKeyCoordinatorDelegate, completion: @escaping (_ hasApiChanged: Bool) -> Void) {
        self.rootViewController = rootViewController
        self.delegate = delegate
        self.completion = completion
    }

    override func start() {
        let service = ApiKeyService(store: LocalDataStore())
        let viewModel = ApiKeyViewModel(service: service)
        let viewController = ApiKeyController.createAlert(viewModel: viewModel) { [weak self ] hasChages in
            guard let self = self else { return }
            self.completion(hasChages)
            self.delegate?.didFinish(from: self)
        }
        rootViewController?.present(viewController, animated: true)
    }
}
