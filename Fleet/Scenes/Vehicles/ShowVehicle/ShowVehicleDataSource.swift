//
//  ShowVehicleDataSource.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

protocol ShowVehicleDataSource: AnyObject {
    func getPositionsOf(vehicleId: String, at date: Date, completion: @escaping (Result<[VehiclePosition], Error>) -> Void)
}

class ShowVehicleRemoteDataSource: ShowVehicleDataSource {
    weak var apiClient: ApiClient?

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getPositionsOf(vehicleId: String, at date: Date, completion: @escaping (Result<[VehiclePosition], Error>) -> Void) {
        guard let apiClient = apiClient else { return }

        var url = apiClient.baseUrl
        url?.path.append(Endpoint.vehiclePositions.value)

        guard let url = url else {
            return completion(.failure(NetworkError.blankUrl))
        }

        let begTimestamp = DateUtils.yearMonthDayFormatter.string(from: date)
        let endTimestamp = DateUtils.yearMonthDayFormatter.string(
            from: Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        )
        let parameters = [
            "begTimestamp": begTimestamp,
            "endTimestamp": endTimestamp,
            "objectId": vehicleId,
        ]
        apiClient.session.request(url, method: .get, parameters: parameters).responseDecodable(of: BodyResponse<[VehiclePosition]>.self) { response in
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

    func getAll(completion: @escaping (Swift.Result<[Vehicle], Error>) -> Void) {
        guard let apiClient = apiClient else { return }

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
