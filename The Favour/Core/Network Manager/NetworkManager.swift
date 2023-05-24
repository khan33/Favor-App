//
//  NetworkManager.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//
import Foundation
import Combine
import SwiftUI

protocol NetworkManagerProtocol: AnyObject {
    typealias Headers = [String: Any]
    typealias Parameters = [String: Any]
    func request<T>(type: T.Type, url: URL, httpMethod: HTTPMethod, headers: Headers, parameters: Parameters?) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkManager: NetworkManagerProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    
    func request<T>(type: T.Type, url: URL, httpMethod: HTTPMethod, headers: Headers, parameters: Parameters?) -> AnyPublisher<T, Error> where T : Decodable {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let params = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        print("===================Request Body & URL ===================")
        print(urlRequest)
        print(headers)
        print(parameters)
        print("======================================")
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            //.map(\.data)
            .tryMap { element -> Data in
                let status = element.response as? HTTPURLResponse
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                if let dataString = String(data: element.data, encoding: .utf8) {
                    print("got dataString and URL \n\(urlRequest) /n ======== /n: \n\(dataString)")
                }
                    return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        
    }
    
    
}
