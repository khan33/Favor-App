//
//  FavorByService.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorByService: View {
    @State private var searchText = ""
    private var service_titles = ["All", "Cleaning", "Repairing", "Painting", "Laundry", "Appliance", "Plumbing", "Movers", "Beauty", "AC Repa..", "Vehicle", "Electronics", "Massage", "Men’s Sal.."]
    @State private var favorDetail = false

    var body: some View {
        
        VStack(spacing: 24) {
            NavigationLink(destination: FavorDetailView(), isActive: $favorDetail) { EmptyView() }
            NavigationBarView(text: "Cleaning")
            
            SearchBarView(searchText: $searchText) {
            }
            
            ScrollView (showsIndicators: false){
                
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"]) {
                    favorDetail.toggle()
                }
                
                
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"])
                
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"])
                
                
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"])
                
            }
            
        }
        .padding(20)
        .navigationBarHidden(true)
        .navigationTitle("")

    }
}

struct FavorByService_Previews: PreviewProvider {
    static var previews: some View {
        FavorByService()
    }
}
