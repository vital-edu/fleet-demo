//
//  ApiRequestInterceptor.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import Alamofire

class ApiRequestInterceptor: RequestInterceptor {
    let service: ApiKeyServiceProtocol

    init(service: ApiKeyServiceProtocol) {
        self.service = service
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        guard let url = urlRequest.url else {
            return completion(.failure(NetworkError.blankUrl))
        }

        service.getApiKey { apiKey in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let keyQueryItem = URLQueryItem(name: "key", value: apiKey)
            let jsonQueryItem = URLQueryItem(name: "json", value: "true")
            if components?.queryItems == nil {
                components?.queryItems = [keyQueryItem, jsonQueryItem]
            } else {
                components?.queryItems?.append(keyQueryItem)
                components?.queryItems?.append(jsonQueryItem)
            }
            urlRequest.url = components?.url
            completion(.success(urlRequest))
        }
    }
}
