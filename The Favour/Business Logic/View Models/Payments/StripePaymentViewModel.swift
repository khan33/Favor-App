//
//  StripePaymentViewModel.swift
//  The Favour
//
//  Created by Atta khan on 28/11/2023.
//

import StripePaymentSheet
import SwiftUI
import Combine

struct CheckoutView: View {
    @ObservedObject var model = MyBackendModel()
    @State private var isPaymentSheetPresented = false

    @State var btnTxt = "Buy Now"
    var body: some View {
        VStack {
        
//            Button {
//                model.preparePaymentSheet() { success in
//                    if let sheet = model.paymentSheet {
//
//                                      PaymentSheet.PaymentButton(
//                                          paymentSheet: sheet,
//                                          onCompletion: model.onCompletion
//                                      ) {
//                                          Text("Loading...")
//                                      }
//
                                                
//                    }
//                }
//            } label: {
//                Text(btnTxt)
//            }

            
            
          if let paymentSheet = model.paymentSheet {
              PaymentSheet.PaymentButton(
                  paymentSheet: paymentSheet,
                  onCompletion: model.onCompletion
              ) {
                  ExamplePaymentButtonView()
              }
          } else {
              ExamplePaymentButtonView()
                  .paymentSheet(isPresented: $model.isPaymentSheetPresented, paymentSheet: model.paymentSheet ?? , onCompletion: model.onCompletion)
                  .onTapGesture {
                      model.preparePaymentSheet() { success in
                          print("true")
                      }
                  }
          }
          if let result = model.paymentResult {
              ExamplePaymentStatusView(result: result)
          }
        }.onAppear {
            //model.preparePaymentSheet()
        }

    }
}

struct ExamplePaymentButtonView: View {
    var body: some View {
        HStack {
            Text("Buy").fontWeight(.bold)
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(6)
        .accessibility(identifier: "Buy button")
    }
}
struct ExampleLoadingView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView()
        } else {
            Text("Preparing payment…")
        }
    }
}

struct ExamplePaymentStatusView: View {
    let result: PaymentSheetResult

    var body: some View {
        HStack {
            switch result {
            case .completed:
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                Text("Success!")
            case .failed(let error):
                Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                Text("Payment failed: \((error as NSError).debugDescription)")
                    .font(.system(size: 12.0))
            case .canceled:
                Image(systemName: "xmark.octagon.fill").foregroundColor(.orange)
                Text("Payment canceled.")
            }
        }
        .accessibility(identifier: "Payment status view")
    }
}


class MyBackendModel: ObservableObject {
    private let authenticationManager: AthenticationManager = AthenticationManager()

    
    let url = "https://favorapp.digitechdeals4u.com/public/api/v1/payment_check_stripe"
    let backendCheckoutUrl = URL(string: "https://aalphahub.com/favorapp/public/api/v1/payment_check_stripe")!
                                    //"https://stripe-mobile-payment-sheet.glitch.me/checkout")!  // An example backend endpoint
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var shouldShowLoader: Bool = false
    private var cancellables = Set<AnyCancellable>()
    @Published var isPaymentSheetPresented = false

    func preparePaymentSheet(completion: @escaping (Bool) -> Void) {
        authenticationManager.stripePayment(booking_id: "23", paymentMethodId: "pm_card_visa")
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.isPaymentSheetPresented = true
                self?.handleStripeResponse(model)
                completion(true)
            }
            .store(in: &cancellables)
        
        
        
        
    }
    
    
    func handleStripeResponse(_ result : StripePaymentResult) {
        
        DispatchQueue.main.async {
//                        self.paymentResult = result
            let customerId = result.data.result.customer
            let customerEphemeralKeySecret = result.data.result.ephemeralKey
            let paymentIntentClientSecret = result.data.result.paymentIntent
            let publishableKey = result.data.result.publishableKey

            print("customer id = \(customerId)")
            
            STPAPIClient.shared.publishableKey = publishableKey

            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()

            configuration.merchantDisplayName = "The Favor App"
//            configuration.applePay = .init(
//                merchantId: "com.foo.example", merchantCountryCode: "US")
            configuration.customer = .init(
                id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.returnURL = "payments-example://stripe-redirect"
            // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
            configuration.allowsDelayedPaymentMethods = true
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(
                    paymentIntentClientSecret: paymentIntentClientSecret,
                    configuration: configuration)
            }
            
        }

    }

    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result

        // MARK: Demo cleanup
        if case .completed = result {
            // A PaymentIntent can't be reused after a successful payment. Prepare a new one for the demo.
            self.paymentSheet = nil
            //preparePaymentSheet()
        }
    }
}
struct StripePaymentResult: Codable {
    let message: String
    let error: Bool
    let code: Int
    let data: PaymentData

    struct PaymentData: Codable {
        let result: PaymentResult

        struct PaymentResult: Codable {
            let paymentIntent: String
            let ephemeralKey: String
            let customer: String
            let publishableKey: String
        }
    }
}
