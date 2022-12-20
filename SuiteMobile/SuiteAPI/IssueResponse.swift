//
//  IssueResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/12/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class IssueResponse : ObservableObject {
    
    
    func fetchissue(project_id: String) {
        
        let baseUrl = "https://suite-api.dev.superb-ai.com/projects/\(project_id)/labels/?group_ordering=-additional_label_type&contains_issue=true"
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do {
                    let parseData = try JSONDecoder().decode(Issue.self, from: data)
                    print(parseData)
//                    self.projectOverview = parseData.results
//                    self.processProjectOverview()
//                    print(self.projectOverview)
                } catch {
                    print("Overview")
                }
            }
    }
}
