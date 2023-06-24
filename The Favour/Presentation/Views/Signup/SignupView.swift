//
//  SignupView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI
import AuthenticationServices


struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingLoginView = false
    @State private var isShowingSignupView = false
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), isActive: $isShowingLoginView) { EmptyView() }
            NavigationLink(destination: MainView(), isActive: $isShowingSignupView) { EmptyView() }
            Image("Signup")
                .resizable()
                .scaledToFit()
                .padding(.top, 80)
                .padding(.bottom, 20)
                .padding(.horizontal, 38)
            FavorText(text: "Sign Up", textColor: .appBlack, fontType: .bold, fontSize: 40.0, alignment: .center, lineSpace: 0)
                .padding(.horizontal, 8)
            
            VStack (spacing: 16){
                FavorSocialButton(text: "Continue with Facebook", image: "fb", width: .infinity, height: 60, fontType: .semiBold, fontSize: 16, action: {
                    
                })
                
                FavorSocialButton(text: "Continue with Google", image: "google", width: .infinity, height: 60, fontType: .semiBold, fontSize: 16, action: {
                    
                })
                
                FavorSocialButton(text: "Continue with Apple", image: "apple", width: .infinity, height: 60, fontType: .semiBold, fontSize: 16, action: {
                    
                })
            }
            HStack(spacing: 24) {
                FavorDividerView(width: (UIScreen.screenWidth / 3), height: 1, bgColor: .appBorderColor)
                FavorText(text:"or")
                FavorDividerView(width: (UIScreen.screenWidth / 3), height: 1, bgColor: .appBorderColor)
            }
            .padding(.vertical, 20)
            
            FavorButton(text: "Sign in with Password", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                self.isShowingLoginView = true
            }
            
            
            HStack(spacing: 0) {
                FavorText(text:"Don’t have an account?")
                
                FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white ) {
                    self.isShowingSignupView = true
                }

            }
            Spacer()
            
        }
        .padding(.horizontal, 24)
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


extension AthenticationViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let token = appleIdCredential.identityToken?.base64EncodedString()  else {
                return
            }
            
            // MARK: TODO
            /// 1. Set token here
            /// 2. Perform tasks to do after login
            self.token = token
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
    
    private func performAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}
