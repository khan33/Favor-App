//
//  ExampleView.swift
//  The Favour
//
//  Created by Atta khan on 09/07/2023.
//

import SwiftUI
import Combine
import CoreLocation

struct ExampleView: View {

    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
                    Text("Current Location:")
                        .font(.headline)
                    
                    if let location = locationManager.currentLocation {
                        Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                            .padding()
                        Text("Current Address: \(locationManager.currentAddress)")
                    } else {
                        Text("Location data not available")
                            .padding()
                    }
                }
                .onAppear {
                    locationManager.startUpdatingLocation()
                }
                .onDisappear {
                    locationManager.stopUpdatingLocation()
                }
    }
    
   
    
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}



