//
//  AthenticationViewModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import Combine
import AuthenticationServices
import Firebase
import CryptoKit

final class AthenticationViewModel: ObservableObject {
    private let authenticationManager: AthenticationManager = AthenticationManager()
    
    private var cancellables = Set<AnyCancellable>()
    @Published var loginIsValid = false
    @Published var showMainTabView: Bool = false
    @Published var nonce = ""

    @Published var email: String = "atta123@gmail.com"
    @Published var password: String = "admin123"
    @Published var confirmPassord: String = ""
    @Published var fullName: String = ""
    @Published var address: String = "Lahore"
    @Published var dateOfBirth: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var shouldShowLoader: Bool = false
    @Published var errorMessage: String = ""
    
    var moveToNextScreen: ((Int) -> Void)?
    var token: String?
    var userType: String?
    init() {
        isLoginFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.loginIsValid, on: self)
          .store(in: &cancellables)
        userType = PrefsManager.shared.favorType
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
                if let data = model.data {
                    if let token = data.token, let type = data.user?.user_type {
                        KeychainManager.saveAuthToken(token)
                        
                        self?.userType = type
                        self?.saveUserType(type)
                        self?.moveToMainTabView()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func saveUserType(_ type: String) {
        PrefsManager.shared.favorType = type
    }
    
    func performSignup() {
        shouldShowLoader = true
        authenticationManager.signup(email: email, password: password, name: fullName, user_type: userType!, contact_number: phoneNumber, address: address, dob: dateOfBirth, id_card: "3241", lat: "30.417947", lng: "74.257103")
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
                
                if let data = model.data {
                    if let token = data.token, let type = data.user?.user_type {
                        KeychainManager.saveAuthToken(token)
                        PrefsManager.shared.username = data.user?.name ?? "Test User"

                        self?.userType = type
                        self?.saveUserType(type)
                        self?.moveToMainTabView()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func moveToMainTabView() {
        shouldShowLoader = false
        showMainTabView = true
    }
    
    
    func logout() {
        shouldShowLoader = true
        authenticationManager.logout(token: "")
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
    
    func resetPassword() {
        shouldShowLoader = true
        authenticationManager.resetPassword(email: email, password: password, token: "", password_confirmation: confirmPassord)
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
    
    func forgotPassword() {
        shouldShowLoader = true
        authenticationManager.forgotPassword(email: email)
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
    
    
    func getUser() {
        shouldShowLoader = true
        authenticationManager.forgotPassword(email: email)
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
    
    
    
    func updateProfile() {
        shouldShowLoader = true
        authenticationManager.forgotPassword(email: email)
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

extension AthenticationViewModel {
    func appleAuthentication(credential: ASAuthorizationAppleIDCredential) {
        // getting token
        guard let token = credential.identityToken else {
            print("Error with Firebase... ")
            return
        }
        
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("Error with token")
            return
        }
        let credential = OAuthProvider.appleCredential(withIDToken: tokenString, rawNonce: nonce, fullName: credential.fullName)
        
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("successfull login....")
        }
    }
}



// helper for Apple login with firebase

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

    
func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}
