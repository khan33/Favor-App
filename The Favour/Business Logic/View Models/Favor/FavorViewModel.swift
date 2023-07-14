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
    @Published var services: [ServiceModelData]?
    @Published var serviceName = [String]()
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var tags: String = "#test, #abc"

    @Published var titleError: String = ""
    @Published var descError: String = ""
    @Published var tagsError: String = ""
    @Published var service : String? = nil
    @Published var selectionIndex = 0

    init() {
        getFavor()
        getService()
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
                }
                if let services = model.services {
                    self?.services = services
                }
                print(model)
            }
            .store(in: &cancellables)
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
                if let services = model.data {
                    for item in services {
                        if let name = item.name {
                            self?.serviceName.append(name)
                        }
                    }
                    print(self?.serviceName)
                }
            }
            .store(in: &cancellables)
    }
    
    func postFavor() {
        if validateInputs() {
            let favor = Favor(title: title, tags: tags, category_id: "3", revisions: "3", total_price: "1000", status: "published", description: desc, meta_data: desc, lat: "", lng: "", address: "", search_tags: tags, favor_id: nil, icon: "")
            favorManager.favorPost(favor: favor)
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
    
    
    func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
    
    func uploadImageToServer(_ image: UIImage, _ completion: @escaping (Bool) -> Void) {
        shouldShowLoader = true

        let category_id = services?[selectionIndex].id ?? 1
        let parameters = [
             "title": title,
             "category_id": String(category_id),
             "revisions": "2",
             "total_price": "1000",
             "status": "published",
             "description": desc,
             "meta_data": desc,
             "lat": "31.417947",
             "lng": "74.257103",
             "tags": tags,
             "address": "Lahore",
             "search_tags": tags,
       ]
       guard let mediaImage = Media(withImage: image, forKey: "icon") else { return }
       guard let url = URL(string: "https://favorapp.mymobilecompare.co.uk/public/api/v1/favors/store") else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       //create boundary
       let boundary = generateBoundary()
       //set content type
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let token = KeychainManager.getAuthToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
       //call createDataBody method
       let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
       request.httpBody = dataBody
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
           self.shouldShowLoader = false
          if let response = response {
             print(response)
          }
          if let data = data {
             do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                completion(true)
             } catch {
                print(error)
             }
          }
       }.resume()
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
