/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IssueView: View {
    
    let issue: [IssueResult]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let project_id: String

    @ObservedObject private var issueThreadResponse = IssueThreadResponse()

    @State var searchKey = ""
    @State var isActive = false // if this set as true then pagination is automatically moved.

    var body: some View {
        HStack{
            TextField("Search labels here", text: $searchKey)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(issue.filter({($0.asset.key?.contains(searchKey))! || searchKey.isEmpty}), id: \.id) { sample in
                    Button {
                        isActive = true
                        issueThreadResponse.fetchIssueThread(project_id: project_id, label_id: sample.id!)
                    } label : {
                        IssueRow(issue: sample)
                    }.background(
                        NavigationLink(destination: IssueDetailView(issueThread: issueThreadResponse.issueThread),
                        isActive: $isActive) {
                           EmptyView()
                        }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct IssueRow: View {
    var issue: IssueResult

    var body: some View {
        Text(issue.asset.key!)
        AsyncImage(url: URL(string: issue.thumbnail!)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.frame(width: 200, height: 100)
    }
}
