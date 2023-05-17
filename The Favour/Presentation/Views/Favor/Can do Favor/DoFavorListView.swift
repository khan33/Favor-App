//
//  DoFavorListView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorListView: View {
    var body: some View {
        VStack {
            topBarView
            
            
            ScrollView {
                DoFavorView()
                DoFavorView()
                DoFavorView()
            }
            .padding(.top, 36)
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))

    }
    
    
    
    @ViewBuilder private var topBarView: some View {
        HStack(spacing: 12) {
            
            Image("heart_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            FavorText(text: "I can do you a favor", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
            Spacer()
            Image("add")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
    }
    
}

struct DoFavorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoFavorListView()
    }
}
