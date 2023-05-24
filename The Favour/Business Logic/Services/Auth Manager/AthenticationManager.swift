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
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error>}

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
    
}
