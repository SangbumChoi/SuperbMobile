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

    var baseUrl = "https://suite-api.dev.superb-ai.com/projects/?page_size=100&page=1"
    
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
                
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
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

class ProjectLabelingStatusResponse: ObservableObject {
    @Published var projectLabelingStatus = [LabelingStatusResult]()
    @Published var processedLabelingStatus = LabelingStatusDataList()
    
    func fetchProjectOverview(id: String){
        
        let baseUrl = "https://suite-api.dev.superb-ai.com/v2/projects/\(id)/overview/"
        print(baseUrl)
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token!
        ]
        
        AF.request(baseUrl, headers: headers)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do {
                    let parseData = try JSONDecoder().decode(LabelingStatus.self, from: data)
                    self.projectLabelingStatus = parseData.results
                    self.processLabelingStatus()
                } catch {
                    print("LabelingStatus")
                }
            }
    }
    
    func processLabelingStatus(){
        var overviewDataList = LabelingStatusDataList()
        
        for overview in self.projectLabelingStatus{
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
        self.processedLabelingStatus = overviewDataList
    }
}

class ProjectMemberResponse: ObservableObject {
    @Published var projectMember = ProjectMemberList()

    var subscription = Set<AnyCancellable>()
    
    func fetchProjectMember(id: String){
        let baseUrl = "https://suite-api.dev.superb-ai.com/v2/projects/\(id)/users/"

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

class ProjectIssueResponse : ObservableObject {
    @Published var projectIssue = [IssueResult]()

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
                    print("issue", parseData)
                    self.projectIssue = parseData.results
//                    self.processProjectOverview()
//                    print(self.projectOverview)
                } catch {
                    print("Issue")
                }
            }
    }
}
