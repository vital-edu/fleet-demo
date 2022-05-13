//
//  AlertModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import UIKit

struct AlertModel {
    let title: String
    let message: String?
    let primaryAction: UIAlertAction
    let secondaryAction: UIAlertAction?

    init(title: String, message: String? = nil, primaryAction: UIAlertAction, secondaryAction: UIAlertAction? = nil) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}
