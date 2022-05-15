//
//  BaseViewController.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 15/05/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    private lazy var loadingIndicator: UIViewController = {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()

        let alert = UIAlertController(title: nil, message: "Loading data...", preferredStyle: .alert)
        alert.view.addSubview(loadingIndicator)

        return alert
    }()
    
    func setLoading(show: Bool) {
        LoadingManager.changeIsLoading { isLoading in
            if show, !isLoading {
                self.present(self.loadingIndicator, animated: true, completion: nil)
            } else if isLoading, !show {
                self.loadingIndicator.dismiss(animated: true)
            }
        }
    }
}
