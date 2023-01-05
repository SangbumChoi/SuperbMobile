//
//  TokenResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/14.
//

import Foundation
import Alamofire
import SwiftyJSON

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class TokenResponse : ObservableObject {
    
//    @Published var tenant_id: String = "datalab-operation"
//    @Published var email: String = "sbchoi@superb-ai.com"
//    @Published var password: String = "Acs8sam0932!"
//    @Published var tenant_id: String = "pingu"
//    @Published var email: String = "tsnoh@superb-ai.com"
//    @Published var password: String = "P@ssw0rd"
    @Published var tenant_id: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
                
        Webservice().login(tenant_id: tenant_id, email: email, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    print("jsonwebtoken", token)
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    defaults.setValue("", forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = false
                    }
                    print(error.localizedDescription)
            }
        }
    }
}

class Webservice {
    
    func login(tenant_id: String, email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "https://suite-api.superb-ai.com/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = try! JSONSerialization.data(withJSONObject: ["tenant_id": tenant_id, "email": email, "password": password], options: [])
//        _ = LoginRequestBody(tenant_id: tenant_id, email: email, password: password)
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
                                    
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                let loginResponse = try? JSONDecoder().decode(JSON.self, from: data)
                print(loginResponse as Any, "login response failed")
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.data.id_token else {
                completion(.failure(.invalidCredentials))
                print("token response failed")
                return
            }

            completion(.success(token))
            
        }.resume()
        
    }
    
}
