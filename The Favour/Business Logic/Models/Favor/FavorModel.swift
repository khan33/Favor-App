//
//  FavorModel.swift
//  The Favour
//
//  Created by Atta khan on 25/06/2023.
//

import Foundation


struct FavorModel: Decodable {
    let message: String
    let error: Bool
    let code: Int
    let total: Int
    let has_page: Bool
    let last_page: Int
    let current_page: Int
    let data: FavorList
}

struct FavorList: Decodable {
    let id: Int
    let time_id: String
    let title: String
    let user_id: Int
    let user_name: String
    let category_id: Int
    let category_name: String
    let revisions: String
    let total_price: String
    let details: String
    let lat: Double
    let lng: Double
    let address: String
}

struct FavorMedia: Decodable {
    let id: Int
    let favor_id: Int
    let media_type: String
    let media_url: String
    let created: String
    let media_description: String
}

struct FavorMediaDetail: Decodable {
    let id: Int
    let favor_id: Int
    let description: String
    let title: String
    let user_id: String

}