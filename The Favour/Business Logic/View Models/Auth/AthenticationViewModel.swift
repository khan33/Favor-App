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

    @Published var email: String = "awais@mal.comm"
    @Published var password: String = "admin123"

    
    @Published var shouldShowLoader: Bool = false
    @Published var errorMessage: String = ""
    var moveToNextScreen: ((Int) -> Void)?
    
    @Published var loginIsValid = false
    var token: String?
    init() {
        isLoginFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.loginIsValid, on: self)
          .store(in: &cancellables)
      }
    
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
//                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model)
            }
            .store(in: &cancellables)
    }
    
    
    func performSignup() {
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
//                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model)
            }
            .store(in: &cancellables)
    }
    
   
}

private extension AthenticationViewModel {
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
        
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
              .map { password in
                  return password.count >= 8
              }
              .eraseToAnyPublisher()
      }
    
    var isLoginFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
          isUserEmailValidPublisher,
          isPasswordValidPublisher)
          .map { isEmailValid, isPasswordValid in
              return isEmailValid && isPasswordValid
          }
          .eraseToAnyPublisher()
      }
}
