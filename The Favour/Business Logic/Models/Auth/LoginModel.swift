//
//  LoginModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation

struct LoginModel: Decodable {
    let status: String
    let data: Login
}


struct Login: Decodable {
    let firstTime: Int?
    let code: Int?
    
    private enum CodingKeys: String, CodingKey {
        case firstTime = "first_time"
        case code
    }
}
