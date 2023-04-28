//
//  SignupView1.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupView1: View {
    @State var fullName: String = ""
    @State var nickName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var dateOfBirth: String = ""
    @State var address: String = ""
    @State var phoneNumber: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            FavorTextField(placeholder: "Full Name", leftImage: nil, rightImage: nil, text: $fullName)
            
            
            FavorTextField(placeholder: "Nick Name", leftImage: nil, rightImage: nil, text: $nickName)
            

            
            FavorTextField(placeholder: "Date of Birth", leftImage: nil, rightImage: "calander", text: $dateOfBirth)
               
            FavorTextField(placeholder: "Email", leftImage: nil, rightImage: "email", text: $email)
            
            FavorTextField(placeholder: "Phone Number", leftImage: nil, rightImage: nil, text: $phoneNumber)
            
            FavorTextField(placeholder: "Address", leftImage: nil, rightImage: "location", text: $address)
            
            
            FavorButton(text: "Sign in with Password", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
            }
                
               
         
            
            
        }
    }
}

struct SignupView1_Previews: PreviewProvider {
    static var previews: some View {
        SignupView1()
    }
}
