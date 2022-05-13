//
//  BodyResponse.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

struct BodyResponse<T>: Decodable where T: Decodable {
    let value: T?
    let status: Int
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case status, response, errorMessage = "errormessage"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorMessage = try? container.decode(String.self, forKey: .errorMessage)
        value = try? container.decode(T.self, forKey: .response)
        status = try container.decode(Int.self, forKey: .status)
    }
}
