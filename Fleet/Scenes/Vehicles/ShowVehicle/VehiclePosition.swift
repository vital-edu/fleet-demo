//
// VehiclePosition.swift
// Fleet
//
// Created by Eduardo Vital Alencar Cunha on 13/05/2022.
//

import Foundation

struct VehiclePosition: Decodable {
    let timestamp: String
    let direction: Int?
    let gpsState: Bool?
    let speed: Int?
    let engineStatus: Bool?
    let latitude: Double
    let longitude: Double
    let distance: Double?
    let power: Double?
    let driverId: Int?

    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case direction = "Direction"
        case gpsState = "GPSState"
        case speed = "Speed"
        case engineStatus = "EngineStatus"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case distance = "Distance"
        case power = "Power"
        case driverId = "DriverId"
    }
}

struct VehiclePositionViewData {
    let latitude: Double
    let longitude: Double

    init(model: VehiclePosition) {
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
}
