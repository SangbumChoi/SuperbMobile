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
    var title: String
    
    var body: some View {
        ZStack {
            Color(hex: "EAEAEA")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView {
                    ForEach(0..<originalImageURL.count, id: \.self) { index in
                        IssueCombineView(index: index, originalImageURL: originalImageURL, issueThread: issueThread)
                    }
                }.tabViewStyle(PageTabViewStyle())
                
            }
        }
        .navigationTitle(title) // navigationLink안에 넣으면 안되는 듯한 느낌
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IssueCombineView: View {
    
    var index: Int
    var originalImageURL: [String]
    var issueThread: [IssueThread]
    
    var body: some View {
        VStack {
            GeometryReader {
                proxy in
                AsyncImage(url: URL(string: originalImageURL[index])) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                } placeholder: {
                    ProgressView()
                }
            }.background(Color(.white))
            
            Text("Issue Comments")
                .fontWeight(.bold)
            
            ScrollView{
                ForEach(0..<issueThread.count, id: \.self) { threadIndex in
                    IssueCommentView(thread: issueThread[threadIndex], index: index, threadIndex: threadIndex)
                }
            }
        }
    }
}

struct IssueCommentView: View {
    
    var thread: IssueThread
    var index: Int
    var threadIndex: Int
    
    var body: some View {
        if thread.info.frameIndex == index {
            ForEach(0..<thread.issueComments.count, id: \.self) { commentIndex in
                VStack(alignment: .leading) {
                    HStack{
                        if commentIndex == 0 {
                            Image("issuethread")
                                .overlay(Text("\(thread.threadNumber)"))
                        } else {
                            Image("reply")
                        }
                        Text("\(thread.issueComments[commentIndex].createdBy.components(separatedBy: "@")[0])")
                            .fontWeight(.bold)
                        Text("\(thread.issueComments[commentIndex].createdAt.components(separatedBy: "T")[0])")
                            .foregroundColor(Color(.systemGray4))
                    }
                    Text(thread.issueComments[commentIndex].message)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(.white)
                .cornerRadius(12)
            }.padding(.horizontal)
        } else {}
    }
}

