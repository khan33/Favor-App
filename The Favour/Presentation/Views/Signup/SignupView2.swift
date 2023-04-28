//
//  SignupView2.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupView2: View {
    var body: some View {
        VStack (spacing: 16){
            FavorText(text: "Steps 2 of 3", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                .padding(.horizontal, 8)
            
            FavorText(text: "We need to verify your information.\nPlease submit any documents from below to process your application.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
            
            
            DocumentButton(title: "ID Card / Driving License")
            DocumentButton(title: "Passport")
            DocumentButton(title: "Tax ID Number")
            
        }
        
       
    }
    
}

struct SignupView2_Previews: PreviewProvider {
    static var previews: some View {
        SignupView2()
    }
}
