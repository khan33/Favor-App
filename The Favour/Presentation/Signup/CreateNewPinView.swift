//
//  CreateNewPinView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct CreateNewPinView: View {
    @State private var otpView: OTPTextView?

    var body: some View {
        VStack {
            FavorText(text: "Add a PIN number to make your account more secure.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
                .tracking(0.2)
            otpTextView
            
            FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .onAppear {
            otpView = OTPTextView()
            otpView?.textOTPView.becomeFirstResponder()
        }
    }
    
    
    private var otpTextView: some View {
        VStack(alignment: .leading, spacing: 4) {
            otpView
                .frame(width: UIScreen.screenWidth - 48, height: 48)
                .padding(24)
        }
    }
}

struct CreateNewPinView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPinView()
    }
}
