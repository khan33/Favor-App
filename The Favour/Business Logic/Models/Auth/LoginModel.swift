//
//  LoginModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation

struct LoginModel: Decodable {
    let message: String
    let error: Bool
    let code: Int
    let data: Login?
}


struct Login: Decodable {
    let token: String?
    let user: User?
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user_details"
    }
}

struct User: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let contact_number: String?
    let email: String?
    let name: String?
    let user_type: String?
    let address: String?
    let dob: String?
    let id_card: String?
    let user_types: String?
    let user_selected_type: String?
    let lat: String?
    let lng: String?
}
