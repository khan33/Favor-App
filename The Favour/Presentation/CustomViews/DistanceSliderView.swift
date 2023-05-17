//
//  DistanceSliderView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI
import SwiftUITooltip

struct DistanceSliderView: View {
    @State private var sliderValue = 50.0
    let minValue: Double
    let maxValue: Double
    let step: Double
    let title: String
    @State var showTooltip: Bool = false
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
           Text(title)
               .font(.headline)
           HStack {
               Text("\(Int(minValue))")
                   
               Slider(value: $sliderValue, in: minValue...maxValue, step: step) { editing in
                   if !editing {
                       showTooltip = true
                   }
               }
               .tint(.appPrimaryColor)
               
               
               Text("\(Int(maxValue))")
                   
                   
           }
//           Text("\(Int(sliderValue))")
//               .foregroundColor(.gray)
//               .font(.subheadline)
       }
       .padding(.horizontal)

    }
    
}

struct DistanceSliderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            DistanceSliderView(minValue: 0, maxValue: 100, step: 1, title: "Location")
            
        }
    }
}
