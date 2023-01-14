//
//  SuiteMobileApp.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/13.
//

import SwiftUI

@main
struct SuiteMobileApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                MainView()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
