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
            
    let mains: [ProjectList]
    let title: String
    
    var body: some View {
        List{
            ForEach(mains) { main in
                Group {
                    if (main.title == "Projects") {
                        NavigationLink(
                            destination: ProjectView(main: main)
                        ) {
                            MainRow(main: main)
                        }
                    }
                    else if (main.title == "Integrations") {
                        NavigationLink(
                            destination: IntegrationsView()
                        ) {
                            MainRow(main: main)
                        }
                    }
                    else if (main.title == "Users") {
                        NavigationLink(
                            destination: UsersView(main: main)
                        ) {
                            MainRow(main: main)
                        }
                    }
                    else {
                        NavigationLink(
                            destination: IntegrationsView()
                        ) {
                            MainRow(main: main)
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MainRow: View {
    var main: ProjectList
    
    var body: some View {
        HStack {
            main.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(main.title)
            Spacer()
        }
    }
}

