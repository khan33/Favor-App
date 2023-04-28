//
//  ProfileView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI
import HalfASheet

struct ProfileView: View {
    @State var isOn = false
    @State var showLogoutSheet: Bool = false

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                avatarImage
                personalInfo
                if isOn == false {
                    availableBalance
                        .padding(.vertical, 4)
                    FavorButton(text: "Withdraw",  width: 160, height: 44, bgColor: .appLightBlack) {
                    }
                }
                switchAccount
                FavorDividerView(width: .infinity, height: 1)
                    .padding(.vertical, 8)
                menuItems
                Spacer()
            }
            .padding(.top, 24)
            
            // MARK: - HALF SHEET FOR LOGOUT
            HalfASheet(isPresented: $showLogoutSheet, title: "Logout") {
                VStack(spacing: 16) {
                    FavorDividerView(width: .infinity, height: 1)
                    FavorText(text: "Are you sure you want to log out?",
                              textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)) , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.vertical, 24)
                    HStack {
                        FavorButton(text: "Cancel", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        FavorButton(text: "Yes, Logout", width: .infinity, height: 60, bgColor: .appPrimaryColor) {

                        }

                    }
                }
            }

            .height(.proportional(0.3))
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 50, leading: 10, bottom: 5, trailing: 10))
        }
        
    }
    
    private var avatarImage: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarView(image: Image("user_profile"), size: 120)
            Image("edit_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(.all, 4)
            
        }
    }
    
    private var personalInfo: some View {
        VStack(spacing: 4) {
            FavorText(text: "Andrew Ainsley", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            
            FavorText(text: "andrew_ainsley@yourdomain.com", textColor: Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)), fontType: .semiBold, fontSize: 14, alignment: .center, lineSpace: 0)
            
        }
    }
    
    
    private var availableBalance: some View {
        Text("Available Balance ").font(.custom("Urbanist Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))) + Text("$40.00").font(.custom("Urbanist Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)))

    }
    
    private var switchAccount: some View {
        Toggle(isOn: $isOn) {
            FavorText(text: self.isOn ? "I can do you a favor" : "I need a favor" , textColor: Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)), fontType: .semiBold, fontSize: 12, alignment: .center, lineSpace: 0)
            }
        .tint(.appPrimaryColor)
        .frame(width: UIScreen.screenWidth / 2, alignment: .center)
    }
    
    
    
    private var menuItems: some View {
        VStack(spacing: 24) {
            SettingMenuItem(title: "Home", image: "Home", isLogout: false)

            SettingMenuItem(title: "Edit Profile", image: "Profile", isLogout: false)

            SettingMenuItem(title: "Payment", image: "Wallet", isLogout: false)

            SettingMenuItem(title: "Security", image: "Shield Done", isLogout: false)

            SettingMenuItem(title: "Privacy Policy", image: "Lock", isLogout: false) {
                print("privacy policy")
            }
            
            SettingMenuItem(title: "Logout", image: "Logout", isLogout: true) {
                showLogoutSheet = true
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return self
            .background {
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet )
            }
    }
}


struct HalfSheetHelper<SheetView: View> : UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
}


// Custom UIHostingController for halfsheet....
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium() ]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
