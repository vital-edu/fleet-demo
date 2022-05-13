//
//  ApiKeyViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 10/05/2022.
//

import UIKit

class ApiKeyController {
    class func createAlert(viewModel: ApiKeyViewModelProtocol, completion: @escaping (_ hasApiChanged: Bool) -> Void) -> UIAlertController {
        let alertView = UIAlertController(
            title: viewModel.title,
            message: nil,
            preferredStyle: .alert
        )
        let primaryAction = UIAlertAction(title: viewModel.primaryButtonText, style: .default) { [weak alertView] action in
            guard let alertView = alertView, let apiKey = alertView.textFields?.first?.text else {
                completion(false)
                return
            }
            viewModel.saveApiKey(apiKey)
            completion(true)
        }
        let secondaryAction = UIAlertAction(title: viewModel.secondaryButtonText, style: .cancel) { action in
            completion(false)
        }

        alertView.addTextField { textField in
            textField.text = viewModel.apiKey.value
            textField.placeholder = viewModel.fieldPlaceholder
            textField.clearButtonMode = .whileEditing
        }

        alertView.addAction(primaryAction)
        alertView.addAction(secondaryAction)

        return alertView
    }
}
