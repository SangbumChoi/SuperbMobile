/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct ProjectView: View {
        
    @ObservedObject private var projectListsResponse = ProjectListsResponse()
    @ObservedObject private var projectLabelingStatusResponse = ProjectLabelingStatusResponse()
    @ObservedObject private var projectMemberResponse = ProjectMemberResponse()
    @ObservedObject private var projectIssueResponse = ProjectIssueResponse()

    @State var searchText = "" 
    @State var isActive = false // if this set as true then pagination is automatically moved.
    
    var body: some View {
        List{
            TextField("Search projects here", text: $searchText)
                .autocapitalization(.none)
            
            ForEach(projectListsResponse.projectLists.filter({($0.name?.contains(searchText))! || searchText.isEmpty}), id: \.id) { sample in
                Button {
                    isActive = true
                    projectLabelingStatusResponse.fetchProjectOverview(id: sample.id!)
                    projectMemberResponse.fetchProjectMember(id: sample.id!)
                    projectIssueResponse.fetchIssue(project_id: sample.id!)
                } label : {
                    ProjectRow(project: sample)
                }.background(
                    NavigationLink(destination: ProjectDetailView(
                                        labelingstatus: projectLabelingStatusResponse.processedLabelingStatus,
                                        issue: projectIssueResponse.projectIssue,
                                        member: projectMemberResponse.projectMember),
                                   isActive: $isActive) {
                                       EmptyView()
                                   })
            }
        }
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
