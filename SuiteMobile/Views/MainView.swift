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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mains: ProjectList.sampleData, title: "pingu")
    }
}

