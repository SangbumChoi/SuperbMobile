//
//  ContentView.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/13/21.
//

import SwiftUI

struct LoginView: View {
        
    @StateObject private var tokenResponse = TokenResponse()
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: tokenResponse.isAuthenticated ? "lock.fill": "lock.open")
                }
                TextField("Tenant_id", text: self.$tokenResponse.tenant_id)
                TextField("Email", text: self.$tokenResponse.email)
                SecureField("Password", text: self.$tokenResponse.password)

                HStack {
                    Spacer()
                    NavigationLink(destination: MainView(mains: ProjectList.sampleData, title: tokenResponse.tenant_id), isActive: $tokenResponse.isAuthenticated) {
                        Button(action : {
                            tokenResponse.login()
                        }) {
                            Text("Login")
                        }
                    }
                    Spacer()
                }
            }.buttonStyle(PlainButtonStyle())
            
        }.onAppear(perform: {
            
        })
        .embedInNavigationView()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
