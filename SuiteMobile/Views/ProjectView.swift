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
                        .foregroundColor(Color(hex: "FF625A"))
                        .frame(width: 55, height: 55)
                    VStack(alignment: .leading) {
                        Text(project.name!)
                            .font(.system(size:22))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Text("\(project.label_count!) labels")
                            .font(.system(size:16))
                            .foregroundColor(.gray)
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
    var imagename: String

    var body: some View {
        Image(imagename)
            .frame(width: 20, height: 20)
            .foregroundColor(Color(hex: "FF625A"))
            .padding(2)
            .background(Color(hex: "FFF6F6"))
            .clipShape(Circle())
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

func generateAnnotationTypeIcon(annotationtype: String) -> CircleImage {
    if (annotationtype == "box") {
        return CircleImage(imagename: "box")
    }
    else if (annotationtype == "rbox") {
        return CircleImage(imagename: "rbox")
    }
    else if (annotationtype == "polyline") {
        return CircleImage(imagename: "polyline")
    }
    else if (annotationtype == "polygon") {
        return CircleImage(imagename: "polygon")
    }
    else if (annotationtype == "keypoint") {
        return CircleImage(imagename: "keypoint")
    }
    else if (annotationtype == "cuboid" || annotationtype == "cuboid2d") {
        return CircleImage(imagename: "cuboid")
    }
    else if (annotationtype == "image category") {
        return CircleImage(imagename: "image_categorization")
    }
    else {
        return CircleImage(imagename: "")
    }
}
