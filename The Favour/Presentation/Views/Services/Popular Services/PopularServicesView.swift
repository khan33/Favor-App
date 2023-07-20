//
//  PopularServicesView.swift
//  The Favour
//
//  Created by Atta khan on 10/05/2023.
//

import SwiftUI

struct PopularServicesView: View {
    @State private var searchText = ""
    private var service_titles = ["All", "Cleaning", "Repairing", "Painting", "Laundry", "Appliance", "Plumbing", "Movers", "Beauty", "AC Repa..", "Vehicle", "Electronics", "Massage", "Men’s Sal.."]
    @State private var favorDetail = false
    var body: some View {
        VStack(spacing: 16) {
            //NavigationLink(destination: FavorDetailView(), isActive: $favorDetail) { EmptyView() }

            NavigationBarView(text: "Most Popular Services")
            
            SearchBarView(searchText: $searchText) {
            }
            
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<service_titles.count) { index in
                        ServiceButtonView(text: service_titles[index], textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite)
                    }
                }
            }
            ScrollView(showsIndicators: false){
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"]) {
                    favorDetail.toggle()
                }
                
                
                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"]) {
                    favorDetail.toggle()
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .navigationTitle("")
        
    }
}

struct PopularServicesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularServicesView()
    }
}
