//
//  SignupView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import GoogleSignIn
import Firebase


struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingLoginView = false
    @State private var isShowingSignupView = false
    
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), isActive: $isShowingLoginView) { EmptyView() }
            NavigationLink(destination: MainView(), isActive: $isShowingSignupView) { EmptyView() }
            
//            NavigationBarView(text: "")

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
                    
                    FirebaseAuth.shared.signInWithGoogle(presenting: getRootViewController()) { error in
                        print(error)
                    }
                    
                    
                })
                
                FavorSocialButton(text: "Continue with Apple", image: "apple", width: .infinity, height: 60, fontType: .semiBold, fontSize: 16, action: {
                    
                    
                })
                .overlay {
                    SignInWithAppleButton { (request) in
                        // requesting param for apple login....
                        viewModel.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(viewModel.nonce)
                    } onCompletion: { (result) in
                        // getting error or success....
                        switch result {
                        case .success(let user):
                            print(user)
                            
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                return 
                            }
                            viewModel.appleAuthentication(credential: credential)


                            // do login with firebase

                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(height: 55)
                    .clipShape(Capsule())
                    .padding(0)
                }
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
