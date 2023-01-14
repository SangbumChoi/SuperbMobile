//
//  URLResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/12/31.
//

import Foundation
import Alamofire
import SwiftyJSON

enum URLError: Error {
    case invalidURL
    case customError(errorMessage: String)
}


class URLResponse : ObservableObject {
    
    @Published var originalImageURL = [String]() // We should not set as empty string value "" here
    @Published var isActive: Bool = false

    func response(asset_id: String, type: String) {
                        
        URLservice().fetchURL(asset_id: asset_id, type: type) { result in
            switch result {
                case .success(let ImageURL):
                    self.originalImageURL = ImageURL
                    print("success", ImageURL)
                    DispatchQueue.main.async {
                        self.isActive = true
                    }
                case .failure(let error):
                    self.originalImageURL = [""]
                    DispatchQueue.main.async {
                        self.isActive = false
                    }
                    print(error.localizedDescription)
            }
        }
    }
}

class URLservice {
    
    func fetchURL(asset_id: String, type: String, completion: @escaping (Result<[String], URLError>) -> Void) {
        
        guard let url = URL(string: "https://suite-api.superb-ai.com/assets/\(asset_id)/read-signed-url/") else {
            completion(.failure(.customError(errorMessage: "URL is not correct")))
            return
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.customError(errorMessage: "No data")))
                return
            }
            
            if type == "img-presigned-url" {
                guard let parseData = try? JSONDecoder().decode(ResponseURL.self, from: data) else {
                    completion(.failure(.invalidURL))
                    return
                }
                let ImageURL = [parseData.url]
                print(ImageURL, "imageURL")
                completion(.success(ImageURL))
            } else if type == "video-presigned-url" {
                guard let parseData = try? JSONDecoder().decode(ResponseVideoURL.self, from: data) else {
                    completion(.failure(.invalidURL))
                    return
                }
                let ImageURL = parseData.url
                print(ImageURL, "videoURL")
                completion(.success(ImageURL))
            } else {
                completion(.failure(.invalidURL))
            }
        }.resume()
        
    }
    
}


//class URLResponse : ObservableObject {
//    @Published var originalImageURL = [String]() // We should not set as empty string value "" here
//
//    func fetchURL(asset_id: String, type: String) {
//
//        let baseUrl = "https://suite-api.superb-ai.com/assets/\(asset_id)/read-signed-url/"
//        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer " + token!
//        ]
//
//        AF.request(baseUrl,
//                   method: .post,
//                   headers: headers)
//            .response { (responseData) in guard let data = responseData.data else {return}
//            if type == "img-presigned-url" {
//                do {
//                    let parseData = try JSONDecoder().decode(ResponseURL.self, from: data)
//                    self.originalImageURL = [parseData.url]
//                    print("url", self.originalImageURL)
//                } catch {
//                    print("url respone", baseUrl)
//                }
//            } else if type == "video-presigned-url" {
//                do {
//                    let parseData = try JSONDecoder().decode(ResponseVideoURL.self, from: data)
//                    self.originalImageURL = parseData.url
//                    print("url", self.originalImageURL)
//                } catch {
//                    print("url respone", baseUrl)
//                }
//            } else {
//                self.originalImageURL = ["None"]
//                print(asset_id, type)
//            }
//        }
//    }
//}
