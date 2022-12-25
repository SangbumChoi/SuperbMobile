//
//  IssueDetailView.swift
//  SuiteMobile
//
//  Created by sangbum choi on 2022/12/25.
//

import SwiftUI

struct IssueDetailView: View {
        
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
