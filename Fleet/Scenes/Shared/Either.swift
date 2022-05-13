//
//  Either.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

enum Either<Success, Failure> {
    case success(Success)
    case failure(Failure)
}
