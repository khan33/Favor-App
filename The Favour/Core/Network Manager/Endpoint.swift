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
        var headers: [String: String] = [ "Content-Type": "application/json"
                                        ]
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
    
    static var register: Self {
        return Endpoint(path: NetworkConstants.register)
    }
    
    static var socialLogin: Self {
        return Endpoint(path: NetworkConstants.socialLogin)
    }
    
    static var logout: Self {
        return Endpoint(path: NetworkConstants.logout)
    }
    
    static var resetPassword: Self {
        return Endpoint(path: NetworkConstants.resetPassword)
    }
    
    static var forgoPassword: Self {
        return Endpoint(path: NetworkConstants.forgotPassword)
    }
    
    static var updateProfile: Self {
        return Endpoint(path: NetworkConstants.updateUserProfile)
    }
    
    static func getUser(Id: String) -> Self {
        return Endpoint(path: NetworkConstants.getUserDetail, queryItems: [URLQueryItem(name: "id", value: Id)])
    }
    static var getUserFavor: Self {
        return Endpoint(path: NetworkConstants.getUserFavor)
    }
    static var userPostFavor: Self {
        return Endpoint(path: NetworkConstants.favorPost)
    }
    
    static var userUpdateFavor: Self {
        return Endpoint(path: NetworkConstants.favorUpdate)
    }
    
    static func getFavor(servicesPageSize: String, page: String, pageSize: String, isServices: String) -> Self {
        return Endpoint(path: NetworkConstants.getFavor, queryItems: [
            URLQueryItem(name: "services_page_size", value: servicesPageSize),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "page_size", value: pageSize),
            URLQueryItem(name: "is_services", value: isServices),
        ])
    }
    
    
    static func getFavorById(Id: String) -> Self {
        return Endpoint(path: NetworkConstants.getFavorDetailById, queryItems: [URLQueryItem(name: "id", value: Id)])
    }
    
    
    static var getService: Self {
        return Endpoint(path: NetworkConstants.getServices, queryItems: [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "page_size", value: "50"),
        ])
    }
    
    
    static var getUserFavorbookingList: Self {
        return Endpoint(path: NetworkConstants.favorBookingByUser)
    }
    static var bookingFavor: Self {
        return Endpoint(path: NetworkConstants.favorBooking)
    }
    
    
}
