//
//  Endpoint.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation


struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.host
        components.path = NetworkConstants.path + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: String] {
        var headers: [String: String] = [ "Content-Type": "application/json",
                                          "lang": "en",
                                          "device": "2" ]
        if let token = KeychainManager.getAuthToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}

extension Endpoint {
    static var login: Self {
        return Endpoint(path: NetworkConstants.loginService)
    }
   
    
//    static func generateVIPAddress(cityId: String) -> Self {
//        return Endpoint(path: NetworkConstants.generateVIPAddressService, queryItems: [URLQueryItem(name: "city_id", value: cityId)])
//    }

    
}
