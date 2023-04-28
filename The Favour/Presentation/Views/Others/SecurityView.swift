//
//  SecurityView.swift
//  The Favour
//
//  Created by Atta khan on 27/04/2023.
//

import SwiftUI

struct SecurityView: View {
    @State var isOnFaceId = false
    @State var isOnBiometricId = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Toggle("Face Id", isOn: $isOnFaceId)
                
            Toggle("Biometric Id", isOn: $isOnBiometricId)
                
                .padding(.bottom, 36)
            FavorButton(text: "Change PIN", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            
            FavorButton(text: "Change Password", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
        }
        .padding()
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
