//
//  FavorByService.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorByService: View {
    @State private var searchText = ""
    @State private var favorDetail = false

    var service: ServiceModelData
    
    var body: some View {
        
        VStack(spacing: 8) {
            //NavigationLink(destination: FavorDetailView(), isActive: $favorDetail) { EmptyView() }
            NavigationBarView(text: service.name ?? "")
            
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
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .navigationTitle("")
        .onAppear {
            
        }

    }
}

struct FavorByService_Previews: PreviewProvider {
    static var previews: some View {
        var service: ServiceModelData = ServiceModelData(id: 1, name: "Cleaning", color: nil, icon: nil, active: "", ispopular: true)
        FavorByService(service: service)
    }
}
