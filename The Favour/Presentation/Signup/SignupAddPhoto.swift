//
//  SignupAddPhoto.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupAddPhoto: View {
    @State private var showModally = false
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                FavorText(text: "Steps 1 of 3", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.horizontal, 8)
                
                ZStack(alignment: .bottomTrailing) {
                    AvatarView(image: Image("avatar"), size: 200)
                    
                    
                    Image("edit_profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                        .padding(.all, 8)
                    
                }
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                }
                
                FavorButton(text: "Skip", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    withAnimation(.linear(duration: 0.3)) {
                        showModally.toggle()
                    }
                    
                    
                }
                Spacer()
                
                
            }
            
            ProfilePicModal(show: $showModally)
        }
    }
    
    
}

struct SignupAddPhoto_Previews: PreviewProvider {
    static var previews: some View {
        SignupAddPhoto()
    }
}
