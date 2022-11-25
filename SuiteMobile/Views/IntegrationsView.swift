/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct IntegrationsView: View {
        
    @State var searchText = ""
    
    var body: some View {
        HStack{
            TextField("Search terms here", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
    }
}
