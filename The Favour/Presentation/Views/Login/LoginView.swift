//
//  LoginView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var isShowingForgotPasswordView = false
    @State private var isShowingSignupView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                NavigationLink(destination: ForgotPasswordView(), isActive: $isShowingForgotPasswordView) { EmptyView() }
                
                NavigationLink(destination: MainView(), isActive: $isShowingSignupView) { EmptyView() }
            }
            FavorText(text: "Login to your Account", textColor: .appBlack, fontType: .bold, fontSize: 36.0, alignment:.leading , lineSpace: 0)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 12)
                .lineLimit(2)
            Group {
                
                FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $email)
                
                FavorTextField(placeholder: "password", leftImage: "Lock", rightImage: nil, text: $password)
                
                HStack {
                    Image("Rectangle")
                        .resizable()
                        .frame(width: 24, height: 24)
                    FavorText(text: "Remember me", textColor: .appBlack, fontType: .bold, fontSize: 14.0)
                }
                .padding(.horizontal,24)
                .padding(.vertical, 16)
                
                FavorButton(text: "Sign in with Password", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                }
                .padding(.horizontal,24)
                
                FavorButton(text: "Forgot the password?", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: .white) {
                    self.isShowingForgotPasswordView = true
                }
                .padding(.horizontal,24)
            }
            HStack(spacing: 24) {
                FavorDividerView(width: (UIScreen.screenWidth / 3), height: 1, bgColor: .appBorderColor)
                FavorText(text:"or")
                FavorDividerView(width: (UIScreen.screenWidth / 3), height: 1, bgColor: .appBorderColor)
                
                
            }
            .padding(.horizontal,24)
            .padding(.bottom, 16)

            HStack {
                SocialIconView(imageName: "fb")
                SocialIconView(imageName: "google")
                SocialIconView(imageName: "apple")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 16)

            
            FavorButton(text: "Guest Login", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            .padding(.horizontal,24)
            
            Spacer()

                HStack(spacing: 0) {
                    FavorText(text:"Don’t have an account?")
                    
                    FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white ) {
                        self.isShowingSignupView = true
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
            
            
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
