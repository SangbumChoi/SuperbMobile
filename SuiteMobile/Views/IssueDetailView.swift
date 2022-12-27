//
//  IssueDetailView.swift
//  SuiteMobile
//
//  Created by sangbum choi on 2022/12/25.
//

import SwiftUI

struct IssueDetailView: View {
    
    var issueThread: [IssueThread]
    var issueImageURL: String
    
    var body: some View {
        ZStack {
            Color(hex: "EAEAEA")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                AsyncImage(url: URL(string: issueImageURL)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                
                ScrollView{
                    ForEach(issueThread, id: \.id) { thread in
                        IssueCommentView(thread: thread)
                    }
                }
            }
        }
    }
}

struct IssueCommentView: View {
    
    var thread: IssueThread
    
    var body: some View {
        ForEach(thread.issueComments, id: \.id) { issuecomments in
            VStack(alignment: .leading) {
                HStack{
                    Text("\(issuecomments.createdBy.components(separatedBy: "@")[0])")
                        .fontWeight(.bold)
                    Text("\(issuecomments.createdAt.components(separatedBy: "T")[0])")
                        .foregroundColor(Color(.systemGray4))
                }
                Text(issuecomments.message)
//                Text(issuecomments.createdAt)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.white)
            .cornerRadius(12)
        }
//        Text("x: \(thread.info.target.point.x), y: \(thread.info.target.point.y)")
    }
}

