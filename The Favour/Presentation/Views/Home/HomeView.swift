//
//  HomeView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    private var service_titles = ["All", "Cleaning", "Repairing", "Painting", "Laundry", "Appliance", "Plumbing", "Movers", "Beauty", "AC Repa..", "Vehicle", "Electronics", "Massage", "Men’s Sal.."]
    
    var body: some View {
        VStack {
            CustomNavigationBarView()
            ScrollView(.vertical, showsIndicators: false) {
                
                SearchBarView(searchText: $searchText)
                
                SeeAllView(label1: "Services", label2: "See All")
                    .padding(.top, 12)
                AllServicesView()
                
                Divider()
                    .padding(.vertical, 24)
                SeeAllView(label1: "Most Popular Services", label2: "See All")
                
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<service_titles.count) { index in
                                ServiceButtonView(text: service_titles[index], textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite)
                                
                                //ServiceButtonView(text: "All is well Cleaning", textColor: .white, bgColor: .appPrimaryColor)
                            }
                        }
                    }
                .padding(.vertical,  20)
                
                ForEach(0..<5) { index in
                    FavorListView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews")
                }

            }
        }
        
        .padding(.horizontal)
        .padding(.top, 24)
        .background(Color.init(hex: "#FAFAFA"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
