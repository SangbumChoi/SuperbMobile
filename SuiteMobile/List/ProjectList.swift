/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import SwiftUI

struct ProjectList: Identifiable {
    let id: UUID
    var title: String
    var imagename : String
    var image: Image {
        Image(imagename)
    }
    
    init(id: UUID = UUID(), title: String, imagename: String) {
        self.id = id
        self.title = title
        self.imagename = imagename
    }
}

extension ProjectList {
    static let sampleData: [ProjectList] =
    [
        ProjectList(title: "Projects", imagename: "projects_icon"),
        // ProjectList(title: "Data", imagename: "data_icon"),
        ProjectList(title: "Users", imagename: "users_icon"),
        // ProjectList(title: "Integrations", imagename: "integrations_icon"),
        ProjectList(title: "Settings", imagename: "settings_icon")
    ]
    // Data and Integeration tab is not enabled in Mobile version.
}
