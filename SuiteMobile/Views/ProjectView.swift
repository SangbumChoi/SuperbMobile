/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct ProjectView: View {
        
    @ObservedObject private var projectListsResponse = ProjectListsResponse()
    @ObservedObject private var projectLabelingStatusResponse = ProjectLabelingStatusResponse()
    @ObservedObject private var projectMemberResponse = ProjectMemberResponse()
    @ObservedObject private var issueResponse = IssueResponse()

    @State var searchText = "" 
    @State var isActive = false // if this set as true then pagination is automatically moved.
    
    var body: some View {
        List{
            TextField("Search projects here", text: $searchText)
                .autocapitalization(.none)
            
            ForEach(projectListsResponse.projectLists.filter({($0.name?.contains(searchText))! || searchText.isEmpty}), id: \.id) { sample in
                Button {
                    isActive = true
                    projectLabelingStatusResponse.fetchProjectOverview(id: sample.id!, title: sample.name!)
                    projectMemberResponse.fetchProjectMember(id: sample.id!)
                    issueResponse.fetchIssue(project_id: sample.id!)
                } label : {
                    ProjectRow(project: sample)
                }.background(
                    NavigationLink(destination: ProjectDetailView(
                    title: projectLabelingStatusResponse.projectTitle,
                    project_id: projectLabelingStatusResponse.projectId,
                    labelingstatus: projectLabelingStatusResponse.processedLabelingStatus,
                    issue: issueResponse.issue,
                    member: projectMemberResponse.projectMember),
                    isActive: $isActive) {
                       EmptyView()
                    }
                )
            }
        }
    }
}


struct ProjectRow: View {
    @State var projectIcon = ""
    var project: ProjectResult

    var body: some View {
        Section {
            VStack {
                HStack {
                    generateDataTypeIcon(datatype: project.label_interface.data_type ?? "")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.orange)
                    VStack(alignment: .leading) {
                        Text(project.name!)
                            .fontWeight(.bold)
                        Text("\(project.label_count!) labels")
                    }
                    Spacer()
                }
                VStack(alignment: .trailing) {
                    HStack {
                        if project.label_interface.object_detection != nil {
                            ForEach(project.label_interface.object_detection!.annotation_types, id: \.self) { annotation_type in
                                generateAnnotationTypeIcon(annotationtype: annotation_type!)
                            }
                        } else {
                            ForEach(project.label_interface.object_tracking!.annotation_types, id: \.self) { annotation_type in
                                generateAnnotationTypeIcon(annotationtype: annotation_type!)
                            }
                        }
                    }
                }
            }
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
        return Image("image")
    }
    else if (datatype == "image sequence") {
        return Image("video")
    }
    else if (datatype == "pointclouds") {
        return Image("pointcloud")
    }
    else {
        return Image(systemName: "photo")
    }
}

func generateAnnotationTypeIcon(annotationtype: String) -> Image {
    if (annotationtype == "box") {
        return Image("box")
    }
    else if (annotationtype == "rotated box") {
        return Image("rbox")
    }
    else if (annotationtype == "polyline") {
        return Image("polyline")
    }
    else if (annotationtype == "polygon") {
        return Image("polygon")
    }
    else if (annotationtype == "keypoint") {
        return Image("keypoint")
    }
    else if (annotationtype == "cuboid" || annotationtype == "cuboid2d") {
        return Image("cuboid")
    }
    else if (annotationtype == "image category") {
        return Image("image_categorization")
    }
    else {
        return Image("aqi.medium")
    }
}
