//
//  VehicleCell.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation
import UIKit

class VehicleCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
