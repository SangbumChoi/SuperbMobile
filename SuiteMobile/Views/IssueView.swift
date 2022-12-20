/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IssueView: View {
    
    let issue: [IssueResult]
        
    @State var searchText = ""
    
    var body: some View {
        
        HStack{
            TextField("Search labels here", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
        
        List(issue.filter({($0.asset.id?.contains(searchText))! || searchText.isEmpty}), id: \.id) { sample in
            Text("test")
        }
        
        VStack{
//            TextField("Label_id", text: self.$issueResponse.label_id)
            AsyncImage(url: URL(string: "https://docs-assets.developer.apple.com/published/7a8d82fa0ae80e1c40ba9a151d56c704/AsyncImage-1@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            AsyncImage(url: URL(string: "https://docs-assets.developer.apple.com/published/7a8d82fa0ae80e1c40ba9a151d56c704/AsyncImage-1@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
        }
    }
}
