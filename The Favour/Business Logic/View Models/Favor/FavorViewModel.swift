//
//  FavorViewModel.swift
//  The Favour
//
//  Created by Atta khan on 07/07/2023.
//


import Foundation
import Combine
import AuthenticationServices
import Firebase
import CryptoKit
import SwiftUI

struct MultipartFormData {
    let name: String
    let value: String
}

final class FavorViewModel: ObservableObject {
    private let favorManager: FavorManager = FavorManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var shouldShowLoader: Bool = false
    @Published var favors: [FavorList]?
    @Published var popularServicFavors: [FavorList]?

    @Published var services: [ServiceModelData]?
    @Published var popularServices: [ServiceModelData]?

    
    @Published var serviceName = [String]()
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var tags: String = "#test, #abc"

    @Published var titleError: String = ""
    @Published var descError: String = ""
    @Published var tagsError: String = ""
    @Published var service : String = ""
    @Published var selectedService: ServiceModelData?
    @Published var alertMsg: String = ""
    @Published var isAlertShow: Bool = false
    init() {
    }
        
    func validateInputs() -> Bool {
        var isValid = true
        
        // Validate username
        if title.isEmpty {
            titleError = "Favor Title is required"
            isValid = false
        } else {
            titleError = ""
        }
        
        
        if tags.isEmpty {
            tagsError = "Tags is required"
            isValid = false
        } else {
            tagsError = ""
        }
        
        
        if desc.isEmpty {
            descError = "Description is required"
            isValid = false
        } else {
            descError = ""
        }
       
        
        return isValid
    }
    
    
    func getUserFavor() {
        shouldShowLoader = true
        
        favorManager.userFavors()
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
                if let data = model.data {
                    self?.favors = data
                }
                
            }
            .store(in: &cancellables)
    }
    
    func getFavor() {
        shouldShowLoader = true
        
        favorManager.getFavor()
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
                
                if let data = model.data {
                    self?.favors = data
                    self?.favors?.sort{ $0.id ?? 0 < $1.id ?? 0 }
                    self?.popularServicFavors = self?.favors
                }
                if let services = model.services {
                    self?.services = services
                    self?.services?.sort{ $0.id ?? 0 < $1.id ?? 0 }
                    
                    self?.popularServices = self?.services?.filter { $0.ispopular == true }
                    self?.popularServices?.insert(ServiceModelData(id: 0, name: "All", color: "", icon: "", active: false, ispopular: true), at: 0)

                }
                print(model)
            }
            .store(in: &cancellables)
    }
    
    func filterFavorbyService(service_id : Int) {
        if service_id != 0 {
            self.popularServicFavors = self.favors?.filter { $0.category_id ?? 0 == service_id }
            return
        }
        self.popularServicFavors = self.favors
        
    }
    
    func getService() {
        shouldShowLoader = true
        
        favorManager.getService()
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
                if model.error == false {
                    if let services = model.data {
                        self?.services = services
                        for item in services {
                            if let name = item.name {
                                self?.serviceName.append(name)
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func postFavor(image: UIImage, lat: String, lng: String, address: String) {
        if validateInputs() {
            shouldShowLoader = true
            let category_id = self.selectedService?.id ?? 0
            let favor = Favor(title: title, tags: tags, category_id: String(category_id), revisions: "3", total_price: "1000", status: "published", description: desc, meta_data: desc, lat: lat, lng: lng, address: address, search_tags: tags, favor_id: nil, icon: "")
            guard let mediaImage = Media(withImage: image, forKey: "icon") else { return }
            favorManager.favorPost(favor: favor, media: [mediaImage])
                .sink { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        self?.shouldShowLoader = false
                        print("Couldn't Post Favor: \(error)")
                    case .finished:
                        self?.shouldShowLoader = false
                        break
                    }
                } receiveValue: { [weak self] model in
                    self?.isAlertShow = true
                    if let data = model.message {
                        print(data)
                    }
                    
                    print(model)
                }
                .store(in: &cancellables)
        }
    }
    
    func deleteFavor() {
        
    }
    
    
    
    
}
struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
