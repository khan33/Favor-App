//
//  CustomNavigationBarView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI

struct CustomNavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack(spacing: 12) {
//            Button(action: {
//                // Action for left button
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Image("ic_back")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 24, height: 24)
//            }
            
            Image("user_profile")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .padding(.leading, 8)
            VStack(alignment: .leading) {
                FavorText(text: "Good Morning 👋", textColor: Color(#colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)), fontType: .medium, fontSize: 16, alignment: .leading, lineSpace: 0)
                FavorText(text: PrefsManager.shared.username, textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 20, alignment: .leading, lineSpace: 0)
            }
            Spacer()
            Image("notification")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        
    }
}

struct CustomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBarView()
    }
}
