//
//  ProjectResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/14.
//

import Foundation
import Combine
import Alamofire

class AllMemberResponse: ObservableObject {
    
    @Published var allMember = [Member]()

    var subscription = Set<AnyCancellable>()
    
    init() {
        fetchAllMember()
    }
    
    func fetchAllMember(){
        let baseUrl = "https://suite-api.dev.superb-ai.com/users/"
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do {
                    let parseData = try JSONDecoder().decode([Member].self, from: data)
                    self.allMember = parseData
                } catch {
                    print("AllMember")
                }
            }
    }
}
