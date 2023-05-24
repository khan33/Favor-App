//
//  AthenticationViewModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import Combine

final class AthenticationViewModel: ObservableObject {
    private let authenticationManager: AthenticationManager = AthenticationManager()
    private var cancellables = Set<AnyCancellable>()

    
    
    @Published var seconds: Int = 60
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var shouldShowPopup: Bool = false
    @Published var shouldShowLoader: Bool = false
    @Published var showMainTabView: Bool = false
    @Published var errorMessage: String = ""
    var moveToNextScreen: ((Int) -> Void)?
    
    
    func performLogin() {
        shouldShowLoader = true
        authenticationManager.login(email: email, password: password)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model)
            }
            .store(in: &cancellables)
    }
    
   
}
