//
//  FavorListView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct FavorListView: View {
    let image: String
    let name: String
    let favTitle: String
    let rating: String
    let totalReview: String
    var action: (() -> Void)? = nil

    var body: some View {
        
        FavorInfoView(image: image, name: name, favTitle: favTitle, rating: rating, totalReview: "|  \(totalReview)")
        
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .onTapGesture {
            action?()
        }
    }
        
}

struct FavorListView_Previews: PreviewProvider {
    static var previews: some View {
        FavorListView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews")
    }
}
