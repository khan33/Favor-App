//
//  LoginView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    @State var email: String = "atta@gmail.com"
    @State var password: String = "2323232"
    @State private var isChecked = false

    @State private var isShowingForgotPasswordView = false
    @State private var isShowingSignupView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                NavigationLink(destination: ForgotPasswordView(), isActive: $isShowingForgotPasswordView) { EmptyView() }
                
                NavigationLink(destination: MainView(), isActive: $isShowingSignupView) { EmptyView() }
            }
            FavorText(text: "Login to your Account", textColor: .appBlack, fontType: .bold, fontSize: 48, alignment:.leading , lineSpace: 0)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                
                FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $viewModel.email)
                
                FavorTextField(placeholder: "password", leftImage: "Lock", rightImage: nil, isPassword: true, text: $viewModel.password)
                
                Button(action: {
                           isChecked.toggle()
                       }) {
                           HStack {
                               Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                   .resizable()
                                   .frame(width: 20, height: 20)
                                   .foregroundColor(Color.appPrimaryColor)
                               FavorText(text: "Remember me", textColor: .appBlack, fontType: .bold, fontSize: 14.0)
                           }
                       }
                    
                    
                
                .padding(.vertical, 16)
                
                FavorButton(text: "Login", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    viewModel.performLogin()
                }
                .opacity(buttonOpacity)
                .disabled(!viewModel.loginIsValid)
                
                FavorButton(text: "Forgot the password?", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: .white) {
                    self.isShowingForgotPasswordView = true
                }
            }
            HStack( alignment: .center, spacing: 24) {
                FavorDividerView(width: 80, height: 1, bgColor: .appBorderColor)
                FavorText(text:"or continue with")
                FavorDividerView(width: 80, height: 1, bgColor: .appBorderColor)
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)

            HStack(alignment: .center) {
                SocialIconView(imageName: "fb")
                SocialIconView(imageName: "google")
                SocialIconView(imageName: "apple")
            }
            .frame(maxWidth: .infinity, alignment: .center)

            
            
            
            Spacer()

            HStack(spacing: 0) {
                FavorText(text:"Don’t have an account?")
                
                FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white ) {
                    self.isShowingSignupView = true
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    var buttonOpacity: Double {
        return viewModel.loginIsValid ? 1 : 0.5
      }
    
    var btnBack : some View {
        Button(action: {
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
