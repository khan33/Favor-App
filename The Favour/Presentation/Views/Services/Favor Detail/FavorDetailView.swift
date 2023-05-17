//
//  FavorDetailView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorDetailView: View {
    @State private var searchText = ""
    private var ratings = ["All", "5", "4", "3", "2", "1", "0"]
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 16) {
                NavigationBarView(text: "Detail")
                
                ScrollView (showsIndicators: false) {
                    favorHeaderInfo
                    FavorDividerView(width: .infinity, height: 0.5)
                    favorPostedInfo
                    favorDesc
                    FavorDividerView(width: .infinity, height: 0.5)
                    
                    favorRatingTitle
                    favorRatingButtons
                    
                    
                    RatingView()
                    
                    RatingView()
                }
            }
            .padding([.horizontal, .top], 24)
            .padding(.bottom, 0)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 110)

                Rectangle()
                    .frame(height: 110)
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.appBorderColor, lineWidth: 1)
                            
                    )
                HStack {
                    FavorButton(text: "Message", width: .infinity, height: 55, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    }
                    FavorButton(text: "Book Favor", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                        
                    }
                }
                .padding(.horizontal, 24)
            }
            
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)
    }
    private func createTopRoundedMask(cornerRadius: CGFloat, height: CGFloat) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: height))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
            path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
        }
    }
    
}

extension FavorDetailView {
    @ViewBuilder private var favorPostedInfo: some View {
        HStack(alignment: .top, spacing: 0) {
            FavorText(text: "Posted 2 min ago", textColor:  Color(red: 0.26, green: 0.26, blue: 0.26), fontType: .medium, fontSize: 14, alignment: .center, lineSpace: 0)
            Spacer()
            AddressView(address: "255 Grand Park Avenue, New York" )
        }
    }
    @ViewBuilder private var favorDesc: some View {
        HStack {
            FavorText(text: "Description", textColor:  .appBlack, fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
            Spacer()
        }
        .padding(.vertical, 12)
        
        
        FavorText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue.", textColor:  .appTitleBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
            .lineLimit(isExpanded ? nil : 3)
            .animation(.easeInOut)
            .overlay(
                    GeometryReader { proxy in
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text(isExpanded ? "Less" : "More")
                                .font(.caption).bold()
                                .padding(.leading, 8.0)
                                .padding(.top, 4.0)
                                .background(Color.white)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                    }
                )
    }
    
    @ViewBuilder private var favorRatingButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<6) { index in
                    RatingStarButtonView(text: ratings[index], textColor: index == 0 ? .white : .appPrimaryColor, fontType: .semiBold, fontSize: 16, bgColor: index == 0 ? .appPrimaryColor : .white)
                }
            }
        }
        .padding(.vertical, 16)
    }
    @ViewBuilder private var favorRatingTitle: some View {
        HStack {
            Image("Star")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            SeeAllView(label1: "4.8 (4,479 reviews)", label2: "See All")
        }
        .padding(.top, 0)
    }
    
    @ViewBuilder private var favorHeaderInfo: some View {
        FavorInfoView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "Cleaning", rating: "4.8", totalReview: "| 8.889")
        
        HStack {
            FavorButton(text: "Cleaning", width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            AddressView(address: "255 Grand Park Avenue, New York" )
        }
    }
}

struct FavorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavorDetailView()
    }
}
