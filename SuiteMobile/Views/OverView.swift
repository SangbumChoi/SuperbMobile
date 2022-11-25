import SwiftUI

struct OverView: View {
    
    let overview: DataList
    let member: ProjectMemberList
    
//    @ObservedObject var projectOverviewResponse = ProjectOverviewResponse()
//    @ObservedObject var projectMemberResponse = ProjectMemberResponse()
        
    var body: some View {
        Section(header: Text("Labeling Status").font(.body)){
            HStack(alignment: .center) {
                VStack {
                    HStack {
                        Circle()
                            .fill(.yellow)
                            .frame(width: 10, height: 10)
                        Text("In Progress")
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow)
                                .frame(
                                    width: metrics.size.width * CGFloat(overview.inprogress_notsubmitted) / CGFloat(overview.inprogress_rejected + overview.inprogress_notsubmitted),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Recjected")
                    Text("\(overview.inprogress_rejected)")
                    Divider()
                    Text("Not Submitted")
                    Text("\(overview.inprogress_notsubmitted)")
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.green)
                            .frame(width: 10, height: 10)
                        Text("Submitted")
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.green.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.green)
                                .frame(
                                    width: metrics.size.width * CGFloat(overview.submitted_approved) / CGFloat(overview.submitted_approved + overview.submitted_pendingreview),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Approved")
                    Text("\(overview.submitted_approved)")
                    Divider()
                    Text("Pending Review")
                    Text("\(overview.submitted_pendingreview)")
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 10, height: 10)
                        Text("Skipped")
                    }
                    ZStack(alignment: .leading) {
                        GeometryReader { metrics in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.2)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray)
                                .frame(
                                    width: metrics.size.width * CGFloat(overview.skipped_approved) / CGFloat(overview.skipped_approved + overview.skipped_pendingreview),
                                    height: metrics.size.height * 0.2)
                        }

                    }.frame(height: 20)
                    Text("Approved")
                    Text("\(overview.skipped_approved)")
                    Divider()
                    Text("Pending Review")
                    Text("\(overview.skipped_pendingreview)")
                }
            }
        }

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

//        Section(header: Text("Project Configuration").font(.body)){
//            VStack (alignment: .leading) {
//                HStack {
//                    Text("Data Type")
//                    Text(project.label_interface.data_type)
//                }
//                HStack {
//                    Text("Annotation Types")
//                    Text(project.label_interface.data_type)
//                }
//                HStack {
//                    Text("Object Class")
//                    Text(project.label_interface.data_type)
//                }
//                HStack {
//                    Text("Image Category")
//                    Text(project.label_interface.data_type)
//                }
//                HStack {
//                    Text("Advanced QA")
//                    Text(project.label_interface.data_type)
//                }
//            }
//            .padding()
//            .font(.subheadline)
//            .foregroundColor(.secondary)
//        }
    }
}

