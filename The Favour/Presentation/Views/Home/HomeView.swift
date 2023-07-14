//
//  HomeView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI
import HalfASheet

struct HomeView: View {
    @State private var searchText = ""
    @State private var isSheetShown = false
    @State var cardDismissal = false
    @State private var isServices = false
    @State var service_titles = ["All", "Cleaning", "Repairing", "Painting", "Laundry", "Appliance", "Plumbing", "Movers", "Beauty", "AC Repa..", "Vehicle", "Electronics", "Massage", "Men’s Sal.."]
    
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
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var popularFavor = false
    @State private var favorDetail = false
    @State private var favorByService = false

    @StateObject var viewModel: FavorViewModel = FavorViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(destination: AllServicesView(services: viewModel.services), isActive: $isServices) { EmptyView() }
                    NavigationLink(destination: PopularServicesView(), isActive: $popularFavor) { EmptyView() }
                    NavigationLink(destination: FavorByService(), isActive: $favorByService) { EmptyView() }
                    
                    
                    
                    CustomNavigationBarView()
                    SearchBarView(searchText: $searchText) {
                        isSheetShown = true
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        SeeAllView(label1: "Services", label2: "See All") {
                            isServices = true
                        }
                        .padding(.top, 12)
                        HomeServicesView
                        
                        Divider()
                            .padding(.vertical, 24)
                        SeeAllView(label1: "Most Popular Services", label2: "See All") {
                            popularFavor.toggle()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if let result = viewModel.services {
                                    ForEach(result.indices, id: \.self) { index in
                                        ServiceButtonView(text: result[index].name, textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite) {
                                            favorByService.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical,  20)
                        if let favor = viewModel.favors {
                            ForEach(favor.indices, id: \.self) { index in
                                FavorListView(image: favor[index].media?[0].media_url ?? "", name: favor[index].category ?? "Cleaning", favTitle: favor[index].title ?? "", rating: "4.8", totalReview: "8.889 reviews") {
                                    favorByService.toggle()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .background(Color.init(hex: "#FAFAFA"))
                .navigationBarHidden(true)
                .navigationTitle("")
                .spinner(isShowing: $viewModel.shouldShowLoader)
                
                FilterModalView(isShowing: $isSheetShown, services: $service_titles)
            }
        }
    }
    
    
    private var HomeServicesView: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 20) {
            if let result = viewModel.services {
                ForEach(result.indices, id: \.self) { index in
                    ServicesView(image: images[index],
                                 name: result[index].name ?? "",
                                 color: colors[index]
                    )
                }
            }
        }
    }
    
    func bottomSheetContent() -> some View {
            // Bottom sheet content goes here
            Text("Hello, world!")
        }
}

struct FilterView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            FavorText(text: "Filter",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            
            FavorDividerView(width: .infinity, height: 1)
            
            DistanceSliderView(minValue: 0, maxValue: 100, step: 1, title: "Location")
            
            FavorText(text: "Category",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            
            
            FavorText(text: "Favor Type",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            
            HStack {
                FavorButton(text: "Part Time", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                FavorButton(text: "Full Time", width: .infinity, height: 44, bgColor: .appPrimaryColor) {
                    
                }
                
            }
            
            FavorDividerView(width: .infinity, height: 1)
            
            HStack {
                FavorButton(text: "Rest", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                FavorButton(text: "Filter", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    
                }
                
            }
            
            Spacer()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



struct BottomCard<Content: View>: View {
    @Binding  var isSheetShown: Bool
    @Binding var cardDismissal: Bool
    let height: CGFloat
    let content: Content

    
    init(isSheetShown: Binding<Bool>, cardDismissal: Binding<Bool>,
         height: CGFloat, @ViewBuilder content: () -> Content) {
        _isSheetShown = isSheetShown
        _cardDismissal = cardDismissal
        self.height = height
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            //  Dimmed
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.red.opacity(0.5))
            .opacity(isSheetShown ? 1 : 0)
            .animation(.easeIn)
            .onTapGesture {
                cardDismissal.toggle()
                isSheetShown.toggle()
            }
            
            // Card
            
            VStack {
                Spacer()
                VStack {
                    content
                }
                .background(Color.white)
                .frame(height: 300)
                .offset(y: isSheetShown ? 0 : 300)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}
