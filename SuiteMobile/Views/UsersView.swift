/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct UsersView: View {
    
    let main: ProjectList
    
    @ObservedObject private var allMemberResponse = AllMemberResponse()
    
    @State var searchText = ""
    @State var isActive = false
    
    var body: some View {
        HStack{
            TextField("Search terms here", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray4))
        .cornerRadius(6)
        .padding(.horizontal)
        
        List {
            ForEach(allMemberResponse.allMember, id: \.self) { member in
                ForEach(member.users.filter({($0.name.contains(searchText)) || searchText.isEmpty}), id: \.self) { idx in
                    VStack{
                        HStack {
                            Text(idx.name)
                                .fontWeight(.bold)
                            Spacer()
                            Text(member.tenant_role)
                        }
                        HStack {
                            Text(idx.email)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
