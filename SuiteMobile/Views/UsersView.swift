/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct UsersView: View {
        
    @ObservedObject private var allMemberResponse = AllMemberResponse()
    
    @State var searchText = ""
    @State var isActive = false
    
    var body: some View {

        List {
            TextField("Search user ID here", text: $searchText)

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
