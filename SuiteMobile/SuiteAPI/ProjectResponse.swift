//
//  ProjectResponse.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/14.
//

import Foundation
import Combine
import Alamofire

class ProjectListsResponse: ObservableObject {
    @Published var projectLists = [ProjectResult]()

    var subscription = Set<AnyCancellable>()
    var baseUrl = "https://suite-api.superb-ai.com/projects/?page_size=1000&page=1"
    
    init() {
        fetchProjectLists()
    }
    
    func fetchProjectLists(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        print(headers)
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                print(data)
                do {
                    let parseData = try JSONDecoder().decode(Project.self, from: data)
                    print(parseData)
                    self.projectLists = parseData.results
                } catch {
                    print("List")
                }
            }
    }
    
}

class ProjectOverviewResponse: ObservableObject {
    
    @Published var projectOverview = [OverviewResult]()
    @Published var projectOverview2 = DataList()

    var subscription = Set<AnyCancellable>()
//    var baseUrl = "https://suite-api.superb-ai.com/v2/projects/538c6147-68dc-4bc7-b0ea-2af76c5ccc82/overview/"
    
//    init(name: String) {
//        fetchProjectOverview(name: "38c6147-68dc-4bc7-b0ea-2af76c5ccc82")
//    }
    
    func fetchProjectOverview(id: String){
        
        let baseUrl = "https://suite-api.superb-ai.com/v2/projects/\(id)/overview/"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do {
                    let parseData = try JSONDecoder().decode(Overview.self, from: data)
                    self.projectOverview = parseData.results
                    self.processProjectOverview()
                    print(self.projectOverview)
                } catch {
                    print("Overview")
                }
            }
    }
    
    func processProjectOverview(){
        var overviewDataList = DataList()
        
        for overview in self.projectOverview{
            if overview.status == "WORKING" && overview.last_review_action == "REJECT" {
                overviewDataList.inprogress_rejected = overview.count!
            }
            if overview.status == "WORKING" && overview.last_review_action == "" {
                overviewDataList.inprogress_notsubmitted = overview.count!
            }
            if overview.status == "SUBMITTED" && overview.last_review_action == "APPROVE" {
                overviewDataList.submitted_approved = overview.count!
            }
            if overview.status == "SUBMITTED" && (overview.last_review_action == "REQUEST" || overview.last_review_action == "") {
                overviewDataList.submitted_pendingreview = overview.count!
            }
            if overview.status == "SKIPPED" && overview.last_review_action == "APPROVE" {
                overviewDataList.skipped_approved = overview.count!
            }
            if overview.status == "SKIPPED" && overview.last_review_action == "REQUEST" {
                overviewDataList.skipped_pendingreview = overview.count!
            }
        }
        self.projectOverview2 = overviewDataList
    }
}

class ProjectMemberResponse: ObservableObject {
    
//    @Published var projectMember = [Member]()
    @Published var projectMember = ProjectMemberList()

    var subscription = Set<AnyCancellable>()
    
    func fetchProjectMember(id: String){
        let baseUrl = "https://suite-api.superb-ai.com/v2/projects/\(id)/users/"

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
                    self.processProjectMember(member: parseData)
//                    self.projectMember = parseData
                } catch {
                    print("Member")
                }
            }
    }
    
    func processProjectMember(member: [Member]) {
        var projectMemberList = ProjectMemberList()

        for m in member {
            if m.tenant_role == "Owner" {
                projectMemberList.manager = m.count
            }
            if m.tenant_role == "Admin" {
                projectMemberList.admin = m.count
            }
            if m.tenant_role == "Collaborator" {
                projectMemberList.labeler = m.count
            }
        }
        self.projectMember = projectMemberList
    }
}
