// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome8 = try Welcome8(json)

import Foundation

struct LoginRequestBody: Codable {
    let tenant_id: String
    let email: String
    let password: String
}

// MARK: - Welcome8
struct LoginResponse: Decodable {
    let message: String?
    let data: DataClass
    let code: String?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let challengeName: Double?
    let refresh_token, access_token, id_token, last_logined_at: String?
    let deviceInfo: Double?
}


// MARK: - Welcome8
struct Project: Decodable {
    let results: [ProjectResult]
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case results = "results"
    }
}

// MARK: - Result
struct ProjectResult: Decodable {
    let id: String?
    let label_count, unique_label_count: Int?
    let name, description, workapp: String?
    let label_interface: LabelInterface
    let is_public: Bool?
    let created_at, created_by, last_updated_at, last_updated_by: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case label_count = "label_count"
        case unique_label_count = "unique_label_count"
        case name = "name"
        case description = "description"
        case workapp = "workapp"
        case label_interface = "label_interface"
        case is_public = "is_public"
        case created_at = "created_at"
        case created_by = "created_by"
        case last_updated_at = "last_updated_at"
        case last_updated_by = "last_updated_by"
    }
}

// MARK: - LabelInterface
struct LabelInterface: Decodable {
    let type, version, data_type: String?
//    let object_detection: ObjectDetection
//    let object_tracking: ObjectTracking

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case version = "version"
        case data_type = "data_type"
//        case object_detection = "object_detection"
//        case object_tracking = "object_tracking"
    }
}


// MARK: - ObjectDetection
struct ObjectDetection: Decodable {
    let annotation_types: [String?]
}

// MARK: - ObjectDetection
struct ObjectTracking: Decodable {
    let annotation_types: [String?]
}

//extension LabelInterface {
//    enum Types: String, Codable {
//        case object_detection
//        case object_tracking
//    }
//
//    var commonData: CommonData {
//        switch self {
//        case .object_detection(let data, _), .object_tracking(let data, _):
//            return data
//        }
//    }
//
//    var type: Types {
//        switch self {
//        case .object_detection:
//            return .object_detection
//        case .object_tracking:
//            return .object_tracking
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        // type
//        var typeContainer = encoder.container(keyedBy: CodingKeys.self)
//        try typeContainer.encode(self.type, forKey: .type)
//
//        // commond data
//        let commonData = self.commonData
//        try commonData.encode(to: encoder)
//
//        // type specific data
//        switch self {
//        case .object_detection(_, let pictureData):
//          try pictureData.encode(to: encoder)
//        case .object_tracking(_, let textData):
//          try textData.encode(to: encoder)
//        }
//    }
//
//
//    init(from decoder: Decoder) throws {
//        // extract type
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let type = try container.decode(Types.self, forKey: .type)
//
//        // extract common data
//        let commonData = try CommonData(from: decoder)
//
//        // extract type-specific data
//        switch type {
//        case .object_detection:
//          let specificData = try ObjectDetection(from: decoder)
//          self = .object_detection(commonData, specificData)
//        case .object_tracking:
//          let specificData = try ObjectTracking(from: decoder)
//          self = .object_tracking(commonData, specificData)
//        }
//    }
//}

// MARK: - Overview
struct LabelingStatus: Decodable {
    let results: [LabelingStatusResult]
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case results = "results"
    }
}

// MARK: - Result
struct LabelingStatusResult: Decodable {
    let status, last_review_action: String?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case last_review_action = "last_review_action"
        case count = "count"
    }
}

// MARK: - Member
struct Member: Hashable, Decodable {
    let tenant_role: String
    let count: Int
    let users: [User]
}

struct User: Hashable, Decodable {
    let email: String
    let status: String
    let name: String
    let lats_logined_at: String?
    let created_at: String
}

struct Issue: Decodable {
    let count: Int?
    let results: [IssueResult]
}

struct IssueResult: Decodable {
    let id: String?
    let asset: Asset
    let openIssueCount: Int?
    let thumbnail: String?
}

// MARK: - Asset
struct Asset: Decodable {
    let id, group, key: String?
    let info: AssetInfo
    let createdAt, createdBy, lastUpdatedAt, lastUpdatedBy: String?

    enum CodingKeys: String, CodingKey {
        case id, group, key, info
        case createdAt = "created_at"
        case createdBy = "created_by"
        case lastUpdatedAt = "last_updated_at"
        case lastUpdatedBy = "last_updated_by"
    }
}

// MARK: - AssetInfo
struct AssetInfo: Decodable {
    let type, fileKey, fileName: String?

    enum CodingKeys: String, CodingKey {
        case type
        case fileKey = "file_key"
        case fileName = "file_name"
    }
}
