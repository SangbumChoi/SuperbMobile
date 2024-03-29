/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IssueView: View {
    
    let issue: [IssueResult]
    let columns = [
        GridItem(.flexible()),
    ]
    let project_id: String

    @ObservedObject private var issueThreadResponse = IssueThreadResponse()
    @ObservedObject private var urlResponse = URLResponse()

    @State var searchKey = ""
    @State var isActive = false // if this set as true then pagination is automatically moved.
    @State var title = ""
    
    var body: some View {
        ZStack{
            Color(hex: "EAEAEA")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                TextField("Search assets here", text: $searchKey)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray4))
                    .cornerRadius(6)
                    .padding(.horizontal)
                
                if issue.count == 0 {
                    Spacer()
                    Text("No available open issues")
                        .font(.system(size:16))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        Section {
                            ForEach(issue.filter({($0.asset.key?.contains(searchKey))! || searchKey.isEmpty}), id: \.id) { sample in
                                NavigationLink(destination: IssueDetailView(issueThread: issueThreadResponse.issueThread,
                                                                            originalImageURL: urlResponse.originalImageURL,
                                                                            title: title),
                                               isActive: $urlResponse.isActive) {
                                    Button(action : {
                                        isActive = true
                                        issueThreadResponse.fetchIssueThread(project_id: project_id, label_id: sample.id)
                                        urlResponse.response(asset_id: sample.asset.id!, type: sample.asset.info.type!)
                                        title = sample.asset.key!
                                    }) { IssueRow(issue: sample) }
                                }
                                
                                
//                                Button {
//                                    isActive = true
//                                    issueThreadResponse.fetchIssueThread(project_id: project_id, label_id: sample.id)
//                                    urlResponse.fetchURL(asset_id: sample.asset.id!, type: sample.asset.info.type!)
//                                    title = sample.asset.key!
//                                } label : {
//                                    IssueRow(issue: sample)
//                                }
//                                .background(
//                                    NavigationLink(destination: IssueDetailView(issueThread: issueThreadResponse.issueThread,
//                                                                                originalImageURL: urlResponse.originalImageURL,
//                                                                                title: title),
//                                                   isActive: $isActive) {EmptyView()}
//                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(.white)
                            .cornerRadius(12)
                        }

                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct IssueRow: View {
    var issue: IssueResult

    var body: some View {
        HStack {
            if issue.thumbnail == nil {
                Image("Jimmy")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)
            } else {
                AsyncImage(url: URL(string: issue.thumbnail!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 48, height: 48)
                .cornerRadius(12)
            }
                        
            Text(issue.asset.key!)
                .font(.system(size:16))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}
