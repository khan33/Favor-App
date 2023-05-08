//
//  SignupAddPhoto.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupAddPhoto: View {
    @State private var showModally = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 24) {
                NavigationLink(destination: SignupView2(), isActive: $isNext) { EmptyView() }

                FavorText(text: "Steps 1 of 3", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.top, 36)
                    .padding(.bottom, 16)
                
                ZStack(alignment: .bottomTrailing) {
                    AvatarView(image: Image("avatar"), size: 200)
                    
                    
                    Image("edit_profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                        .padding(.all, 8)
                    
                }
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    isNext = true
                }
                
                FavorButton(text: "Skip", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    withAnimation(.linear(duration: 0.3)) {
                        showModally.toggle()
                    }
                    
                    
                }
                Spacer()
                
                
            }
            .padding()
            ProfilePicModal(show: $showModally)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Fill Your Profile")
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

struct SignupAddPhoto_Previews: PreviewProvider {
    static var previews: some View {
        SignupAddPhoto()
    }
}
