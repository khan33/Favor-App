//
//  PostFavorView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct PostFavorView: View {
    
    @State var title: String = ""
    @State private var description: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            NavigationBarView(text: "Post a favor")
            
            FavorTextField(placeholder: "Select Service", leftImage: nil, rightImage: "down", text: $email)
            
            FavorTextField(placeholder: "Title", leftImage: nil, rightImage: nil, text: $title)
                .padding(.top, 24)
            
            
                
                        
                    
                
            
           
               
            
            
            
            
            
            
            FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
            }
            .padding(.top, 24)
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct PostFavorView_Previews: PreviewProvider {
    static var previews: some View {
        PostFavorView()
    }
}
