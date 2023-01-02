//
//  ProjectResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/14.
//

import Foundation
import Combine
import Alamofire
import SwiftUI


class IssueResponse : ObservableObject {
    @Published var issue = [IssueResult]()

    func fetchIssue(project_id: String) {
        
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
                    self.issue = parseData.results
                    print("issue", self.issue)
                } catch {
                    print("Issue")
                }
            }
    }
}


class IssueThreadResponse : ObservableObject {
    @Published var issueThread = [IssueThread]()
    
    func fetchIssueThread(project_id: String, label_id: String) {
        
        let baseUrl = "https://suite-api.dev.superb-ai.com/projects/\(project_id)/labels/\(label_id)/issue-threads/"
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do {
                    let parseData = try JSONDecoder().decode([IssueThread].self, from: data)
                    self.issueThread = parseData
                    print("issueThread", self.issueThread)
                } catch {
                    print("Issue")
            }
        }
    }
}
