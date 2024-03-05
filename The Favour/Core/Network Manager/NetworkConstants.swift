//
//  NetworkConstants.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation

struct NetworkConstants {
    static let scheme = "https"
    static let host = "aalphahub.com"
//https:aalphahub.com/favorapp/public/api/v1
    static let path = "/favorapp/public/api/v1/"
    
    static let loginService = "login"
    static let register = "register"
    static let socialLogin = "loginWithSocial"
    static let logout = "logout"
    static let resetPassword = "reset-password"
    static let forgotPassword = "forget-password"
    static let payment_check_stripe = "payment_check_stripe"
    
    
    static let getFavor = "favors"
    static let getFavorDetailById = "favors/details?favor_id=10"
    
    static let favorBookingByUser = "favors/bookings"
    static let favorBooking = "favors/bookings/store"
    
    static let getServices = "services"
    static let getUserDetail = "user"
    static let updateUserProfile = "user"
    
    
    static let favorUpdate = "favors/update"
    static let favorPost = "favors/store"
    static let getUserFavor = "favors/user"
}
