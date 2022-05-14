//
//  SecretsManager.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 13/05/2022.
//

import Foundation

class SecretsManager {
    static private(set) var googleMapsKey: String = {
        let fileName = "Secrets"
        let fileExtension = "plist"
        let file = "\(fileName)/\(fileExtension)"
        let keyName = "GOOGLE_MAPS_KEY"

        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            fatalError("Couldn't find file '\(file)'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: keyName) as? String else {
            fatalError("Couldn't find key '\(keyName)' in '\(file)'.")
        }

        if (value.isEmpty) {
            fatalError("Use your Google Maps Key in \(file).")
        }

        return value
    }()
}
