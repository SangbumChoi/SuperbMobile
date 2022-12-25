//
//  IssueDetailView.swift
//  SuiteMobile
//
//  Created by sangbum choi on 2022/12/25.
//

import SwiftUI

struct IssueDetailView: View {
    
    var issueThread: [IssueThread]
    
    var body: some View {
        ForEach(issueThread, id: \.id) { thread in
            IssueCommentView(thread: thread)
        }
    }
}

struct IssueCommentView: View {
    
    var thread: IssueThread
    
    var body: some View {
        Section() {
            ForEach(thread.issueComments, id: \.id) { issuecomments in
                Text(issuecomments.createdBy.components(separatedBy: "@")[0])
                Text(issuecomments.message)
                Text(issuecomments.createdAt)
            }
            Text("x: \(thread.info.target.point.x), y: \(thread.info.target.point.y)")
        }
    }
}

