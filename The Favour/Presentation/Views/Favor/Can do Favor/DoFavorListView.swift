//
//  DoFavorListView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorListView: View {
    @State private var addPost = false
    @ObservedObject private var viewModel: FavorViewModel = FavorViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PostFavorView(), isActive: $addPost) { EmptyView() }

                topBarView
                if viewModel.favors?.count == 0 {
                    Spacer()
                    FavorText(text: "No Favor found!", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                    Spacer()

                } else {
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        if let favor = viewModel.favors {
                            ForEach(favor.indices, id: \.self) { index in
                                DoFavorView(favor: favor[index])
                            }
                        }
                    }
                }
            }
            .padding(24)
            .navigationBarHidden(true)
            .navigationTitle("")
            .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
        }
        .onAppear {
            viewModel.getUserFavor()
        }

    }
    
    
    
    @ViewBuilder private var topBarView: some View {
        HStack(spacing: 12) {
            
            Image("heart_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            FavorText(text: "I can do you a favor", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
            Spacer()
            Image("add")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .onTapGesture {
                    addPost = true
                }
        }
    }
    
}

struct DoFavorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoFavorListView()
    }
}
