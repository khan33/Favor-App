//
//  ReportView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ReportCardView(title: "Fraud")
            ReportCardView(title: "Offensive Content")
            ReportCardView(title: "Duplicate Favor")
            ReportCardView(title: "Other")
        }
        .padding()
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
