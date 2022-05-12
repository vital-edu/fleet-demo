//
//  Vehicle.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 08/05/2022.
//

import Foundation

struct Vehicle: Codable {
    let objectId: Int
    let orgId: Int
    let timestamp: String
    let latitude: Double
    let longitude: Double
    let speed: Int
    let enginestate: Int
    let gpsstate: Bool
    let direction: Int
    let fuel: String?
    let power: Double
    let CANDistance: Double
    let available: Bool
    let driverId: Int
    let driverUuid: String?
    let driverName: String
    let driverKey: String?
    let driverPhone: String?
    let driverStatuses: [String]
    let driverIsOnDuty: Bool
    let dutyTags: [String]
    let pairedObjectId: String?
    let pairedObjectName: String?
    let lastEngineOnTime: String
    let inPrivateZone: Bool?
    let offWorkSchedule: Bool
    let tripPurposeDinSet: String?
    let tcoData: String?
    let tcoCardIsPresent: Bool
    let address: String
    let addressArea: Bool
    let addressAreaId: String?
    let addressAreaUuid: String?
    let displayColor: String?
    let employeeId: String?
    let currentOdometer: String?
    let currentWorkhours: String?
    let enforcePrivacyFilter: String?
    let EVStateOfCharge: String?
    let EVDistanceRemaining: String?
    let customValues: [String]
    let EventType: String
    let objectName: String
    let externalId: String?
    let plate: String
    let CANRPM: String?
    let GreenDrivingValue: Double
    let GreenDrivingType: Int
}

struct VehicleViewData {
    let leftTitle: String
    let rightTitle: String
    let leftSubtitle: String
    let rightSubtitle: String

    init(model: Vehicle) {
        self.leftTitle = "\(model.plate) / \(model.driverName)"
        self.rightTitle = "\(model.speed) / km/h"
        self.leftSubtitle = model.address
        // TODO: format lastEngineOnTime
        self.rightSubtitle = "\(model.lastEngineOnTime)"
    }
}
