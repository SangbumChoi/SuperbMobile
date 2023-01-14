//
//  ContentView.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/13/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var tokenResponse = TokenResponse()
    @EnvironmentObject var authentication: Authentication
    
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
                
                VStack {
                    VStack{
                        TextField("Tenant_id", text: $tokenResponse.credentials.tenant_id)
                            .disableAutocorrection(true)
                        TextField("Email", text: $tokenResponse.credentials.email)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $tokenResponse.credentials.password)
                    }.padding()

                    Button{ tokenResponse.login { success in
                        authentication.updateValidation(success: success)
                        }
                    } label: {
                        Text("Conitue")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .bold()
                    }
                    .disabled(tokenResponse.loginDisabled)
                    .foregroundColor(.white)
                    .background(Color(hex: "FF625A"))
                    .cornerRadius(6)
                    .padding(.leading)
                    .padding(.trailing)

//                    if authentication.biometricType() != .none {
//                        Button {
//                            authentication.requestBiometricUnlock { (result:Result<Credentials, Authentication.AuthenticationError>) in
//                                switch result {
//                                case .success(let credentials):
//                                    tokenResponse.credentials = credentials
//                                    tokenResponse.login { success in
//                                        authentication.updateValidation(success: success)
//                                    }
//                                case .failure(let error):
//                                    tokenResponse.error = error
//                                }
//                            }
//                        } label: {
//                            Image(systemName: authentication.biometricType() == .face ? "faceid" : "touchid")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                        }
//                    }
                    
                    if tokenResponse.showProgressView {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .background(Color(hex: "EAEAEA"))
            }
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disabled(tokenResponse.showProgressView)
            .alert(item: $tokenResponse.error) { error in
//                if error == .credentialsNotSaved {
//                    return Alert(title: Text("Credentials Not Saved"),
//                                 message: Text(error.localizedDescription),
//                                 primaryButton: .default(Text("OK"), action: {
//                        tokenResponse.storeCredentialsNext = true
//                    }),
//                                 secondaryButton: .cancel())
//                } else {
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
//                }
            }
        }
    }
}
