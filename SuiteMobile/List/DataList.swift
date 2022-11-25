/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

struct DataList: Hashable, Codable {
    var inprogress_rejected: Int = 0
    var inprogress_notsubmitted: Int = 0
    var submitted_approved: Int = 0
    var submitted_pendingreview: Int = 0
    var skipped_approved: Int = 0
    var skipped_pendingreview: Int = 0
}

struct ProjectMemberList: Hashable, Codable {
    var admin: Int = 0
    var manager: Int = 0
    var labeler: Int = 0
}
