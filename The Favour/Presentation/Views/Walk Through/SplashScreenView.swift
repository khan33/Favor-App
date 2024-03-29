//
//  SplashScreenView.swift
//  The Favour
//
//  Created by Atta khan on 06/04/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack() {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
                Spacer()
                Image("splash_bg")
                    .resizable()
                    .frame(width: .infinity, height: 400)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                        PrefsManager.shared.isWalkThrough = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
