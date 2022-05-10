//
//  ViewConfiguration.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

public protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

extension ViewConfiguration {
    public func buildLayout(){
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    public func configureViews() {}
}
