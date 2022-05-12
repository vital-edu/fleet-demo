//
//  ApiKeyViewModel.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 09/05/2022.
//

import Foundation

protocol ApiKeyViewModelProtocol {
    var service: ApiKeyServiceProtocol { get }

    // MARK: - Data Source

    var title: String { get }
    var primaryButtonText: String { get }
    var secondaryButtonText: String { get }
    var fieldPlaceholder: String { get }
    var apiKey: Dynamic<String> { get set }

    // MARK: - Events

    func saveApiKey(_ value: String)
}

struct ApiKeyViewModel: ApiKeyViewModelProtocol {
    var service: ApiKeyServiceProtocol
    var title: String
    var primaryButtonText: String
    var secondaryButtonText: String
    var fieldPlaceholder: String
    var apiKey: Dynamic<String>

    init(service: ApiKeyServiceProtocol) {
        self.service = service
        self.title = "Enter API Key"
        self.primaryButtonText = "OK"
        self.secondaryButtonText = "Cancel"
        self.fieldPlaceholder = "API key"
        self.apiKey = Dynamic("")

        service.getApiKey { apiKey in
            guard let apiKey = apiKey else { return }
            self.apiKey.value = apiKey
        }
    }

    func saveApiKey(_ value: String) {
        service.save(apiKey: value)
    }
}
