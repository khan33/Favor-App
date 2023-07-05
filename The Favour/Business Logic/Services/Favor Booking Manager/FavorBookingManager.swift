//
//  FavorBookingManager.swift
//  The Favour
//
//  Created by Atta khan on 25/06/2023.
//


import Foundation
import Combine

protocol FavorBookingManagerProtocol: AnyObject {
    var networkManager: NetworkManagerProtocol { get }
    func userFavorBookingList() -> AnyPublisher<LoginModel, Error>
    func userBookedFavor(favor: BookingFavor ) -> AnyPublisher<LoginModel, Error>
    

}

final class FavorBookingManager: FavorBookingManagerProtocol {
    
    let networkManager: NetworkManagerProtocol
        
    init() {
        networkManager = NetworkManager()
    }

    func userFavorBookingList() -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.getUserFavorbookingList
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)

    }
    func userBookedFavor(favor: BookingFavor ) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.bookingFavor
        let params = [
            "total_price": favor.total_price,
            "favor_date": favor.favor_date,
            "favor_time": favor.favor_time,
            "revisions": favor.revisions,
            "details": favor.details,
            "favor_id": favor.favor_id,
            "lat": favor.lat,
            "lng": favor.lng,
            "address" : favor.address,
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }


    
    
}
