//
//  VehiclesDataSource.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation
import Alamofire

protocol VehiclesDataSource {
    func save(value: [Vehicle])
    func deleteAll()
    func getAll(completion: @escaping (Swift.Result<[Vehicle], Error>) -> Void)
}

class VehiclesLocalDataSource: VehiclesDataSource {
    let store: UserDefaults
    let key = UserDefaultsKey.vehicles.rawValue

    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
    }

    func save(value: [Vehicle]) {
        store.set(value, forKey: key)
    }

    func deleteAll() {
        store.removeObject(forKey: key)
    }

    func getAll(completion: (Swift.Result<[Vehicle], Error>) -> Void) {
        let vehicles = store.object(forKey: key) as? [Vehicle] ?? []
        completion(.success(vehicles))
    }
}

class VehiclesRemoteDataSource: VehiclesDataSource {
    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func save(value: [Vehicle]) {
        // TODO: Implement
    }

    func deleteAll() {
        // TODO: Implement
    }

    func getAll(completion: @escaping (Swift.Result<[Vehicle], Error>) -> Void) {
        var url = apiClient.baseUrl
        url?.path.append(Endpoint.vehicles.value)

        guard let url = url else {
            return completion(.failure(NetworkError.blankUrl))
        }

        apiClient.session.request(url, method: .get).responseDecodable(of: BodyResponse<[Vehicle]>.self) { response in
            switch response.result {
            case .success(let data):
                guard let value = data.value else {
                    return completion(.failure(NetworkError.responseWithError(message: data.errorMessage)))
                }
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
