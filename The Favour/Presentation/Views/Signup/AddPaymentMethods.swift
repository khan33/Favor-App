//
//  AddPaymentMethods.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct AddPaymentMethods: View {
    var body: some View {
        VStack (spacing: 16){
            FavorText(text: "Steps 3 of 3", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                .padding(.horizontal, 8)
            
            FavorText(text: "Add a payment method to get paid", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
            
            PaymentButtonView(image: "google", method: "Google Pay", status: "Not Connected")
            
            PaymentButtonView(image: "apple", method: "Apple Pay", status: " Connected")
            
            PaymentButtonView(image: "mastercard", method: "Add Card", status: "Not Connected")
            
            
            FavorButton(text: "Add New ", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
            }
            
            FavorButton(text: "Skip", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
        }
    }
}

struct AddPaymentMethods_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentMethods()
    }
}