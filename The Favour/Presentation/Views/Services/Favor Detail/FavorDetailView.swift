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
    @State private var isNext = false

    
    var favor_detail: FavorList
    init(favor_detail: FavorList) {
        self.favor_detail = favor_detail
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: BookingDetailView(), isActive: $isNext) { EmptyView() }

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
            .padding([.horizontal, .top], 20)
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
                        isNext = true
                    }
                }
                .padding(.horizontal, 24)
            }
            
        }
        .navigationBarHidden(true) // Hide the navigation bar on this screen
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            print(favor_detail)
        }
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
            FavorText(text: "Posted: \(UtilityManager.shared.getTimeAgoString(from: favor_detail.time_id ?? ""))", textColor:  Color(red: 0.26, green: 0.26, blue: 0.26), fontType: .medium, fontSize: 14, alignment: .center, lineSpace: 0)
            Spacer()
            AddressView(address: favor_detail.address ?? "" )
        }
    }
    @ViewBuilder private var favorDesc: some View {
        HStack {
            FavorText(text: "Description", textColor:  .appBlack, fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
            Spacer()
        }
        .padding(.vertical, 12)
        
        
        FavorText(text: favor_detail.meta_details?.description ?? "", textColor:  .appTitleBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
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
                    RatingStarButtonView(text: ratings[index], textColor: index == 0 ? .white : .appPrimaryColor, fontType: .semiBold, fontSize: 14, bgColor: index == 0 ? .appPrimaryColor : .white)
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
            SeeAllView(label1: "4.8 (479 reviews)", label2: "See All")
        }
        .padding(.top, 0)
    }
    
    @ViewBuilder private var favorHeaderInfo: some View {
        FavorInfoView(image: favor_detail.media?[0].media_url ?? "", name: favor_detail.category ?? "", favTitle: favor_detail.title ?? "", rating: "4.8", totalReview: "| 8.889")
        
        HStack {
            FavorButton(text: favor_detail.category ?? "", width: 90, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            Spacer()
            AddressView(address: favor_detail.address ?? "" )

        }
    }
}

struct FavorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var favor_detail: FavorList = FavorList(id: 0, time_id: "", title: "Washing cloths", user_id: nil, user_name: nil, category_id: 5, category: "Cleaning", revisions: nil, total_price: nil, details: nil, lat: nil, lng: nil, address: nil, media: nil, meta_details: nil)

        FavorDetailView(favor_detail: favor_detail)
    }
}
