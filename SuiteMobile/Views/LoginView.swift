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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "FED843"), Color(hex: "FD4B54")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Image("Jimmy_rm")
                    VStack (alignment: .leading) {
                        Text("Hello,")
                            .font(.system(size:24))
                        Text("Welcome to Suite Mobile")
                            .font(.system(size:24))
                            .fontWeight(.bold)
                    }
                }
                
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
                        NavigationLink(destination: MainView(title: tokenResponse.tenant_id),
                                       isActive: $tokenResponse.isAuthenticated) {
                            Button(action : {
                                tokenResponse.login()
                            }) {
                                Text("Login")
                            }
                        }
                        Spacer()
                    }
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear(perform: {})
        .embedInNavigationView()
    }
}

//struct Login_Preveiws: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
