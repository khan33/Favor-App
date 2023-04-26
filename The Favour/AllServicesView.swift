//
//  AllServicesView.swift
//  The Favour
//
//  Created by Atta khan on 06/04/2023.
//

import SwiftUI

struct AllServicesView: View {
    let items = 1...20
    
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(items, id:\.self) { item in
                        Image(systemName: "\(item).circle.fill")
                            .font(.largeTitle)
                    }
                }
            }
            .padding()
            
            
            
            /*
            ScrollView {
                LazyVGrid(columns: colums, alignment: .center) {
                    ForEach(items, id: \.self) { item in
                        VStack(spacing: 8) {
                            Image(systemName: "\(item).circle.fill")
                                .font(.largeTitle)
                            Text("Service")
                                .font(.body)
                        }
                        .padding()
                        
                    }
                }
            }
            .padding()
            */
        
    }
}

struct AllServicesView_Previews: PreviewProvider {
    static var previews: some View {
        AllServicesView()
    }
}
