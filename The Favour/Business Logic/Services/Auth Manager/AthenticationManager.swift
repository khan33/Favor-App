//
//  AthenticationManager.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import Combine

protocol AthenticationManagerProtocol: AnyObject {
    var networkManager: NetworkManagerProtocol { get }
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error>
    func signup(email: String, password: String, c_password: String, user_type: String, contact_number: String, address: String, dob: String, id_card: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error>
}

final class AthenticationManager: AthenticationManagerProtocol {
    
    let networkManager: NetworkManagerProtocol
        
    init() {
        networkManager = NetworkManager()
    }
    
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.login
        let params = ["email": email, "password": password]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func signup(email: String, password: String, c_password: String, user_type: String, contact_number: String, address: String, dob: String, id_card: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.register
        let params = [
            "email": email,
            "password": password,
            "c_password": c_password,
            "user_type": user_type,
            "contact_number": contact_number,
            "address": address,
            "dob": dob,
            "id_card": id_card,
            "lat": lat,
            "lng": lng
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
}
