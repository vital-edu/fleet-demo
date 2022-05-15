//
//  LoadingManager.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 15/05/2022.
//

import Foundation

class LoadingManager {
    private static var isLoading: Bool = false
    private static let locker = NSRecursiveLock()

    static func changeIsLoading(operation: @escaping (Bool) -> Void) {
        locker.lock()
        let item = DispatchWorkItem {
            operation(isLoading)
            isLoading = !isLoading
            locker.unlock()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: item)
    }
}
