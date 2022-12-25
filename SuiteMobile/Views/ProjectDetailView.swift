//
//  ProjectDetailView.swift
//  SuiteMobile
//
//  Created by sangbum choi on 2022/12/25.
//

import SwiftUI

struct ProjectDetailView: View {
    
    var title: String
    var project_id: String
    var labelingstatus: LabelingStatusDataList
    var issue: [IssueResult]
    var member: ProjectMemberList

    var body: some View {
        List {
            LabelingStatusView(labelingstatus: labelingstatus)
            
            MemberRolesView(member: member)
            
            IssuesView(issue: issue, project_id: project_id)

            
//            Section(header: LabelRow(name: "Analytics", imagename: "chart.line.uptrend.xyaxis")){
//                NavigationLink(destination: IssueView(issue: issue, project_id: project_id)) {
//                    Text("Project Analytics")
//                }
//                NavigationLink(destination: IssueView(issue: issue, project_id: project_id)) {
//                    Text("User Reports")
//                }
//                Label("QA is not currently supported", systemImage: "xmark.seal")
//            }
//
//            Section(header: LabelRow(name: "ETC", imagename: "wrench.and.screwdriver")) {
//                NavigationLink(destination: IssueView(issue: issue, project_id: project_id)) {
//                    Text("Project Members")
//                }
//                NavigationLink(destination: IssueView(issue: issue, project_id: project_id)) {
//                    Text("Settings")
//                }
//            }
        }
        .navigationTitle(title) // navigationLink안에 넣으면 안되는 듯한 느낌
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IssuesView: View {
    
    var issue: [IssueResult]
    var project_id: String
    
    var body: some View {
        Section(header: Text("ISSUES").font(.body)) {
            NavigationLink(destination: IssueView(issue: issue, project_id: project_id)) {
                Text("View Open Issues")
            }
        }
    }
}


struct LabelingStatusView: View {
    
    let labelingfontsize = CGFloat(13)
    
    var labelingstatus: LabelingStatusDataList

    var body: some View {
        Section(header: Text("Labeling Status").font(.body)){
            HStack(alignment: .center) {
                VStack {
                    HStack {
                        Circle()
                            .fill(.yellow)
                            .frame(width: 10, height: 10)
                        Text("In Progress")
                            .font(.system(size: labelingfontsize))
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow)
                                .frame(
                                    width: metrics.size.width * CGFloat(labelingstatus.inprogress_notsubmitted) / CGFloat(labelingstatus.inprogress_rejected + labelingstatus.inprogress_notsubmitted),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Recjected")
                    Text("\(labelingstatus.inprogress_rejected)")
                    Divider()
                    Text("Not Submitted")
                    Text("\(labelingstatus.inprogress_notsubmitted)")
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.green)
                            .frame(width: 10, height: 10)
                        Text("Submitted")
                            .font(.system(size: labelingfontsize))
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.green.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.green)
                                .frame(
                                    width: metrics.size.width * CGFloat(labelingstatus.submitted_approved) / CGFloat(labelingstatus.submitted_approved + labelingstatus.submitted_pendingreview),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Approved")
                    Text("\(labelingstatus.submitted_approved)")
                    Divider()
                    Text("Pending Review")
                    Text("\(labelingstatus.submitted_pendingreview)")
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 10, height: 10)
                        Text("Skipped")
                            .font(.system(size: labelingfontsize))
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray)
                                .frame(
                                    width: metrics.size.width * CGFloat(labelingstatus.skipped_approved) / CGFloat(labelingstatus.skipped_approved + labelingstatus.skipped_pendingreview),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Approved")
                    Text("\(labelingstatus.skipped_approved)")
                    Divider()
                    Text("Pending Review")
                    Text("\(labelingstatus.skipped_pendingreview)")
                }
            }
        }
    }
}

struct MemberRolesView: View {
    
    var member: ProjectMemberList

    var body: some View {
        Section(header: Text("Member Roles").font(.body)){
            HStack (alignment: .center) {
                VStack {
                    Text("\(member.admin)")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text("Admin")
                }.frame(maxWidth: .infinity)
                Divider()
                VStack {
                    Text("\(member.manager)")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text("Manager")
                }.frame(maxWidth: .infinity)
                Divider()
                VStack {
                    Text("\(member.labeler)")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text("Labeler")
                }.frame(maxWidth: .infinity)
            }
            .padding()
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
