/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IssuesView: View {
    
    let project_id: String
        
    @State var searchText = ""
    @StateObject private var issueResponse = IssueResponse()
    
    var body: some View {
        VStack{
            TextField("Label_id", text: self.$issueResponse.label_id)
            AsyncImage(url: URL(string: "https://docs-assets.developer.apple.com/published/7a8d82fa0ae80e1c40ba9a151d56c704/AsyncImage-1@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
        }
    }
}
