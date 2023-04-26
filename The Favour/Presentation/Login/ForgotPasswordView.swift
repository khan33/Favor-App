//
//  ForgotPasswordView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            
            FavorText(text: "Forgot Password", textColor: .appBlack, fontType: .bold, fontSize: 36.0, alignment:.leading , lineSpace: 0)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .padding(.bottom, 12)
                .lineLimit(2)
            
            FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $email)
            
            FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $email)
                .padding(.horizontal,8)

            
            FavorButton(text: "Submit", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
            }
            .padding(.horizontal,24)
                        
            HStack(spacing: 0) {
                FavorText(text:"Don’t have an account?")
                
                FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white )
                
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
