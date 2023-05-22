//
//  NeedFavorView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct NeedFavorView: View {
    @State private var isNext = false
    var body: some View {
        VStack() {
            
            NavigationLink(destination: MyRequestView(), isActive: $isNext) { EmptyView() }
            topBarView
            ScrollView {
                NeedFavorCellView()
                NeedFavorCellView()
                NeedFavorCellView()
            }
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
    }
}

extension NeedFavorView {
    @ViewBuilder private var topBarView: some View {
        HStack(spacing: 12) {
            
            Image("heart_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            FavorText(text: "I need a favor", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
            Spacer()
            FavorButton(text: "My Requests", width: 110, height: 30) {
                isNext = true
            }

        }
    }
}

struct NeedFavorView_Previews: PreviewProvider {
    static var previews: some View {
        NeedFavorView()
    }
}
