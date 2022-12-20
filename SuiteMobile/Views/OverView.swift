import SwiftUI

struct OverView: View {
    
    let labelingstatus: LabelingStatusDataList
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

