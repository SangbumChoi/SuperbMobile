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
                        
            TabView {
                if originalImageURL.count > 0 {
                    ForEach(0..<originalImageURL.count, id: \.self) { index in
                        IssueCombineView(
                            originalImageURL: originalImageURL[index],
                            originalImageSize: imageDimenssions(url: originalImageURL[index]),
                            issueThread: issueThread.filter({($0.info.frameIndex == index)})
                        )
                    }
                }
                else {
                    Text("\(originalImageURL.count)")
                }
            }.tabViewStyle(PageTabViewStyle())
        }
        .navigationTitle(title) // navigationLink안에 넣으면 안되는 듯한 느낌
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @MainActor func imageDimenssions(url: String) -> CGSize {
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return CGSize(width: pixelWidth, height: pixelHeight)
            }
        }
        return CGSize(width: 0, height: 0)
    }
}

struct IssueCombineView: View {
    
    var originalImageURL: String
    var originalImageSize: CGSize
    var issueThread: [IssueThread]
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack {
                    AsyncImage(url: URL(string: originalImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    ForEach(issueThread, id: \.id) { issuethread in
                        Image("issuethread")
                            .overlay(Text("\(issuethread.threadNumber)").foregroundColor(.white))
                            .position(
                                calculateXY(issuethreadX: issuethread.info.target.point.x,
                                            issuethreadY: issuethread.info.target.point.y,
                                            originalImageW: originalImageSize.width,
                                            originalImageH: originalImageSize.height,
                                            proxyW: proxy.size.width,
                                            proxyH: proxy.size.height)
                            )
                    }
                }.modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
            }.background(Color(.white))
            
            Text("Issue Comments")
                .fontWeight(.bold)
            
            ScrollView{
                ForEach(0..<issueThread.count, id: \.self) { threadIndex in
                    IssueCommentView(thread: issueThread[threadIndex], threadIndex: threadIndex)
                }
            }
        }
    }
    
    func calculateXY(issuethreadX: Double, issuethreadY: Double, originalImageW: CGFloat, originalImageH: CGFloat, proxyW: CGFloat, proxyH: CGFloat) -> CGPoint {
        if originalImageW * proxyH < originalImageH * proxyW {
            let resizeRatio = proxyH / originalImageH
            let X = (proxyW - originalImageW * resizeRatio) / 2 + issuethreadX * resizeRatio
            let Y = issuethreadY * proxyH / originalImageH
            print(X, Y, resizeRatio, originalImageW, originalImageH, issuethreadX, issuethreadY, proxyW, proxyH)
            return CGPoint(x: X, y: Y)
        } else {
            let resizeRatio = proxyW / originalImageW
            let X = issuethreadX * proxyW / originalImageW
            let Y = (proxyH - originalImageH * resizeRatio) / 2 + issuethreadY * resizeRatio
            print(X, Y, resizeRatio, originalImageW, originalImageH, issuethreadX, issuethreadY, proxyW, proxyH)
            return CGPoint(x: X, y: Y)
        }
    }
}


struct IssueCommentView: View {
    
    var thread: IssueThread
    var threadIndex: Int
    
    var body: some View {
        ForEach(0..<thread.issueComments.count, id: \.self) { commentIndex in
            VStack(alignment: .leading) {
                HStack{
                    if commentIndex == 0 {
                        Image("issuethread")
                            .overlay(
                                Text("\(thread.threadNumber)")
                                    .foregroundColor(.white)
                            )
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
    }
}
