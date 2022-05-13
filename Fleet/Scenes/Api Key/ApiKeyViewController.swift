//
//  ApiKeyViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 10/05/2022.
//

import UIKit

class ApiKeyController {
    var viewModel: ApiKeyViewModelProtocol

    required init(viewModel: ApiKeyViewModelProtocol) {
        self.viewModel = viewModel
    }

    func present(from viewController: UIViewController, completion: @escaping (_ hasApiChanged: Bool) -> Void) {
        let alertView = UIAlertController(
            title: viewModel.title,
            message: nil,
            preferredStyle: .alert
        )
        let primaryAction = UIAlertAction(title: viewModel.primaryButtonText, style: .default) { [weak self] action in
            guard let self = self, let apiKey = alertView.textFields?.first?.text else {
                return
            }
            self.viewModel.saveApiKey(apiKey)
            completion(true)
        }
        let secondaryAction = UIAlertAction(title: viewModel.secondaryButtonText, style: .cancel)

        alertView.addTextField { [weak self] textField in
            guard let self = self else { return }
            self.viewModel.apiKey.bindAndFire { [weak textField] apiKey in
                textField?.text = self.viewModel.apiKey.value
            }
            textField.placeholder = self.viewModel.fieldPlaceholder
            textField.clearButtonMode = .whileEditing
        }

        alertView.addAction(primaryAction)
        alertView.addAction(secondaryAction)

        viewController.present(alertView, animated: true)
    }
}
