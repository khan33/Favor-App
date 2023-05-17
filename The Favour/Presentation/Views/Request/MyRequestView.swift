//
//  MyRequestView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct MyRequestView: View {
    var body: some View {
        VStack {
            NavigationBarView(text: "My Request")
            ScrollView {
                RequestView()
                RequestView()
            }
            
        }   
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))

        
        
    }
}

struct MyRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MyRequestView()
    }
}
