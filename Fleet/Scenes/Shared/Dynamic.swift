//
//  Dynamic.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

class Dynamic<Type> {
    typealias Listener = (Type) -> ()

    var listener: Listener?
    var value: Type {
        didSet { listener?(value) }
    }

    init(_ value: Type) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
