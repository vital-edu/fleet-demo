//
//  ApiClient.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 08/05/2022.
//

import Foundation
import Alamofire

protocol ApiClientProtocol {
    var baseUrl: String { get }
}

class ApiClient {
    let baseUrl = URLComponents(string: "https://app.ecofleet.com/seeme/Api/Vehicles")
    let session: Session

    convenience init(service: ApiKeyServiceProtocol) {
        let session = Session(interceptor: ApiRequestInterceptor(service: service))
        self.init(session: session)
    }

    init(session: Session) {
        self.session = session
    }
}
