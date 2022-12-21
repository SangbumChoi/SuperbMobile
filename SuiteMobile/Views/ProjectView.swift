/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct ProjectView: View {
    
    let main: ProjectList
    
    @ObservedObject private var projectListsResponse = ProjectListsResponse()
    @ObservedObject private var projectLabelingStatusResponse = ProjectLabelingStatusResponse()
    @ObservedObject private var projectMemberResponse = ProjectMemberResponse()
    @ObservedObject private var projectIssueResponse = ProjectIssueResponse()

    @State var searchText = ""
    @State var isActive = true
    
    var body: some View {
        HStack{
            TextField("Search projects here", text: $searchText)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
        
        List(projectListsResponse.projectLists.filter({($0.name?.contains(searchText))! || searchText.isEmpty}), id: \.id) { sample in
            Button {
                    isActive = true
                    projectLabelingStatusResponse.fetchProjectOverview(id: sample.id!)
                    projectMemberResponse.fetchProjectMember(id: sample.id!)
                    projectIssueResponse.fetchIssue(project_id: sample.id!)
                } label : {
                    ProjectRow(project: sample)
                }.background(
                NavigationLink(destination: ProjectDetail(project: sample,
                                                          labelingstatus: projectLabelingStatusResponse.processedLabelingStatus,
                                                          issue: projectIssueResponse.projectIssue,
                                                          member: projectMemberResponse.projectMember),
                               isActive: $isActive) {
                    EmptyView()
                })
            }
//        .environment(\.defaultMinListRowHeight, 50)
        .navigationTitle(main.title)
        .navigationBarTitleDisplayMode(.inline)
        }
}

struct ProjectDetail: View {
    
    var project: ProjectResult
    var labelingstatus: LabelingStatusDataList
    var issue: [IssueResult]
    var member: ProjectMemberList

    var body: some View {
        List {
            OverView(
                labelingstatus: labelingstatus,
                member: member
            )
            
            Section(header: LabelRow(name: "Issues", imagename: "list.star")) {
                NavigationLink(destination: IssueView(issue: issue)) {
                    Text("Issues")
                }
            }
            
//            Section(header: LabelRow(name: "Auto-Label", imagename: "wand.and.stars")) {
//                NavigationLink(destination: LabelsView()) {
//                    Text("Auto-Label Settings")
//                }
//                NavigationLink(destination: LabelsView()) {
//                    Text("Custom Auto-Label")
//                }
//            }
//
//            Section(header: Label("Export", systemImage: "square.and.arrow.down")) {
//                HStack{
//                    Label("Export function is not supported in iOS", systemImage: "xmark.seal")
//                }
//            }
            
            Section(header: LabelRow(name: "Analytics", imagename: "chart.line.uptrend.xyaxis")){
                NavigationLink(destination: IssueView(issue: issue)) {
                    Text("Project Analytics")
                }
                NavigationLink(destination: IssueView(issue: issue)) {
                    Text("User Reports")
                }
                Label("QA is not currently supported", systemImage: "xmark.seal")
            }
            
            Section(header: LabelRow(name: "ETC", imagename: "wrench.and.screwdriver")) {
                NavigationLink(destination: IssueView(issue: issue)) {
                    Text("Project Members")
                }
                NavigationLink(destination: IssueView(issue: issue)) {
                    Text("Settings")
                }
            }
        }
        .navigationTitle(project.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProjectRow: View {
    @State var projectIcon = ""
    var project: ProjectResult

    var body: some View {
        Section {
            HStack {
                generateDataTypeIcon(datatype: project.label_interface.data_type ?? "")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.orange)
                VStack(alignment: .leading) {
                    Text(project.name!)
//                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    Text("\(project.label_count!) labels")
//                        .foregroundColor(Color.black.opacity(0.5))
                }
                Spacer()
            }
        }
    }
}

struct LabelRow: View {
    var name: String
    var imagename: String

    var body: some View {
        HStack {
            Image(systemName: imagename)
                .resizable()
                .frame(width: 25, height: 25)
            Text(name)
            Spacer()
        }
    }
}

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

func generateDataTypeIcon(datatype: String) -> Image {
    if (datatype == "image") {
        return Image(systemName: "photo")
    }
    else if (datatype == "image sequence") {
        return Image(systemName: "video")
    }
    else if (datatype == "pointclouds") {
        return Image(systemName: "aqi.medium")
    }
    else {
        return Image(systemName: "photo")
    }
}

func generateAnnotationTypeIcon(annotationtype: String) -> Image {
    if (annotationtype == "box") {
        return Image(systemName: "rectangle")
    }
    else if (annotationtype == "rotated box") {
        return Image(systemName: "diamond")
    }
    else if (annotationtype == "polyline") {
        return Image(systemName: "arrow.triangle.swap")
    }
    else if (annotationtype == "polygon") {
        return Image(systemName: "seal")
    }
    else if (annotationtype == "keypoint") {
        return Image(systemName: "hand.point.up.braille")
    }
    else if (annotationtype == "cuboid") {
        return Image(systemName: "seal")
    }
    else if (annotationtype == "image category") {
        return Image(systemName: "line.3.horizontal")
    }
    else {
        return Image(systemName: "aqi.medium")
    }
}
