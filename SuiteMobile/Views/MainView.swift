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
            
    let title: String
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            ProjectView()
                .tabItem{
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Projects")
                }
            IntegrationsView()
                .tabItem{
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Integrations")
                }
            UsersView()
                .tabItem{
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Users")
                }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
