//
//  TokenResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/14.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Credentials: Codable {
//    var tenant_id: String = ""
//    var email: String = ""
//    var password: String = ""
    
    var tenant_id: String = "datalab-operation"
    var email: String = "sbchoi@superb-ai.com"
    var password: String = "Acs8sam0932!"
    
    func encoded() -> String {
        let encoder = JSONEncoder()
        let credentialsData = try! encoder.encode(self)
        return String(data: credentialsData, encoding: .utf8)!
    }

    static func decode(_ credentialsString: String) -> Credentials {
        let decoder = JSONDecoder()
        let jsonData = credentialsString.data(using: .utf8)
        return try! decoder.decode((Credentials.self), from: jsonData!)
    }
}


@MainActor class TokenResponse : ObservableObject {
    
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var storeCredentialsNext = false
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        
        let defaults = UserDefaults.standard
        showProgressView = true
        APIService.shared.login(credentials: credentials) { [unowned self](result:Result<String, Authentication.AuthenticationError>) in
            DispatchQueue.main.sync {
                self.showProgressView = false

                switch result {
                case .success(let token):
                    if self.storeCredentialsNext {
                        if KeychainStorage.saveCredentials(self.credentials) {
                            self.storeCredentialsNext = false
                        }
                    }
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    completion(true)
                    
                case .failure(let authError):
                    self.credentials = Credentials()
                    self.error = authError
                    completion(false)
                }
            }
        }
    }
}

class APIService {
    static let shared = APIService()
    
    func login(credentials: Credentials, completion: @escaping (Result<String, Authentication.AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "https://suite-api.superb-ai.com/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["tenant_id": credentials.tenant_id, "email": credentials.email, "password": credentials.password], options: [])
        
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
        }
        .resume()
    }
}
