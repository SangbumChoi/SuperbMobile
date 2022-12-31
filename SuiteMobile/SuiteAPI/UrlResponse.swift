//
//  URLResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/12/31.
//

import Foundation
import Combine
import Alamofire
import SwiftUI


class URLResponse : ObservableObject {
    @Published var originalImageURL = [String]() // We should not set as empty string value "" here

    func fetchURL(asset_id: String, type: String) {
        
        let baseUrl = "https://suite-api.dev.superb-ai.com/assets/\(asset_id)/read-signed-url/"
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl,
                   method: .post,
                   headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                if type == "img-presigned-url" {
                    do {
                        let parseData = try JSONDecoder().decode(ResponseURL.self, from: data)
                        self.originalImageURL = [parseData.url]
                        print("url", self.originalImageURL)
                    } catch {
                    }
                }
                if type == "video-presigned-url" {
                    do {
                        let parseData = try JSONDecoder().decode(ResponseVideoURL.self, from: data)
                        self.originalImageURL = parseData.url
                        print("url", self.originalImageURL)
                    } catch {
                    }
                }
            }
    }
}
