//
//  NetworkError.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case blankUrl
    case invalidUrl(String)
    case responseWithError(message: String?)

    var errorDescription: String? {
        switch self {
        case .blankUrl:
            return "Blank url"
        case .invalidUrl(let url):
            return "The url is invalid: \(url)"
        case .responseWithError(let message):
            return message ?? "Unknown error"
        }
    }
}
