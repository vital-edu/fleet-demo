//
//  Endpoint.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 08/05/2022.
//

import Foundation

enum Endpoint: String {
    case vehicles = "Vehicles"

    var value: String {
        switch self {
        case .vehicles:
            return "/getLastData"
        }
    }
}
