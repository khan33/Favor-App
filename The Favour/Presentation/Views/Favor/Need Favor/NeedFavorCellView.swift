//
//  NeedFavorCellView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct NeedFavorCellView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(.appWhite)
            VStack(alignment: .leading) {
                FavorInfoView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4", totalReview: "|  45")
                
                VStack(alignment: .leading, spacing: 10) {
                    FavorText(text: "Lorem ipsum dolor sit amet, consect.....", textColor: .appLightBlack, fontType: .regular, fontSize: 14, alignment: .center, lineSpace: 0)
                    FavorButton(text: "In Progress", width: 110, height: 30, textColor: Color.orange, bgColor: .appWhite)
                        .border(Color.orange, width: 0.5, cornerRadius: 24)
                }
                .padding(.leading, 20)
                    
            }
            
        }
    }
}

struct NeedFavorCellView_Previews: PreviewProvider {
    static var previews: some View {
        NeedFavorCellView()
    }
}
