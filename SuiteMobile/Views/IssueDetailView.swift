//
//  IssueDetailView.swift
//  SuiteMobile
//
//  Created by sangbum choi on 2022/12/25.
//

import SwiftUI

struct IssueDetailView: View {
    
    var issueThread: [IssueThread]
    var originalImageURL: [String]
    
    var body: some View {
        ZStack {
            Color(hex: "EAEAEA")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView {
                    ForEach(originalImageURL, id: \.self) { imageurl in
                        GeometryReader {
                            proxy in
                            AsyncImage(url: URL(string: imageurl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }.tabViewStyle(PageTabViewStyle())
                
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

