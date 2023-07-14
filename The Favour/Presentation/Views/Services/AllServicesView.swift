//
//  AllServicesView.swift
//  The Favour
//
//  Created by Atta khan on 06/04/2023.
//

import SwiftUI

struct AllServicesView: View {
    
    var services: [ServiceModelData]?
    
    init(services: [ServiceModelData]?) {
        self.services = services
    }
    

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    //Color(red: 0.447, green: 0.063, blue: 1, alpha: 0.08).cgColor
    private var colors: [Color] = [
                                Color(red: 0.447, green: 0.063, blue: 1),
                                Color(red: 1, green: 0.596, blue: 0),
                                Color(red: 0.2, green: 0.369, blue: 0.969),
                                Color(red: 0.98, green: 0.8, blue: 0.082),
                                Color(red: 0.969, green: 0.333, blue: 0.333),
                                Color(red: 0.298, green: 0.686, blue: 0.314),
                                Color(red: 0, green: 0.737, blue: 0.831),
                                Color(red: 0.447, green: 0.063, blue: 1),
                                Color(red: 0.298, green: 0.686, blue: 0.314),
                                Color(red: 0.2, green: 0.369, blue: 0.969),
                                Color(red: 1, green: 0.596, blue: 0),
                                Color(red: 0.969, green: 0.333, blue: 0.333),
                                Color(red: 0.447, green: 0.063, blue: 1),
    ]

    
    private var images = ["cleaning", "Repairing", "painting", "Laundry", "Appliance", "plumbing", "Truck", "beauty", "AC", "vehicle", "electronics", "massage", "Men"]
    
    private var titles = ["Cleaning", "Repairing", "Painting", "Laundry", "Appliance", "Plumbing", "Movers", "Beauty", "AC Repa..", "Vehicle", "Electronics", "Massage", "Men’s Sal.."]
    
    
    var body: some View {
        VStack {
            NavigationBarView(text: "All Services")
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    if let result = services {
                        
                        ForEach(result.indices, id: \.self) { index in
                            ServicesView(image: images[index],
                                         name: result[index].name ?? "",
                                         color: colors[index]
                            )
                        }
                        
                    }
                    
                    
                    
                }
            }
            .padding(.top, 20)
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct AllServicesView_Previews: PreviewProvider {
    static var previews: some View {
        let service: [ServiceModelData] = []
        AllServicesView(services: service)
    }
}
