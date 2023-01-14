//
//  ContentView.swift
//  SuiteMobile
//
//  Created by sangbumchoi on 2022/09/13.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct MainView: View {
            
    @EnvironmentObject var authentication: Authentication
    @State var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab){
                ProjectView()
                    .tabItem{
                        Image("dashboard")
                        Text("Projects")
                    }
                IntegrationsView()
                    .tabItem{
                        Image("doughnut_chart")
                        Text("Integrations")
                    }
                UsersView()
                    .tabItem{
                        Image("ulist")
                        Text("Users")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log out") {
                        authentication.updateValidation(success: false)
                    }
                }
            }
        }
    }
}
