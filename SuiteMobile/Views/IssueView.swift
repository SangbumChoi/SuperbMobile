/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IssueView: View {
    
    let issue: [IssueResult]
        
    @State var searchKey = ""
    
    var body: some View {
        
        HStack{
            TextField("Search labels here", text: $searchKey)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
        
        List(issue.filter({($0.asset.key?.contains(searchKey))! || searchKey.isEmpty}), id: \.id) { sample in
            Text(sample.asset.key!)
            AsyncImage(url: URL(string: sample.thumbnail!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 100)
        }
    }
}
