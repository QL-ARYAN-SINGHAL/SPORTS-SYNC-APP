//
//  FeedDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.

import SwiftUI

struct FeedDataModal: Identifiable, Codable {
    var makeNavigation: Bool = false
    var captionPost: String = ""
    var id: String = ""              // Firestore Document ID
    var uniqueID: String = ""        // User UID
    var postLike: Int = 0
    var postTime: Date = Date()
    var base64Image: String? = nil
    var likedUsers: [String]? = []

    // New fields
    var username: String = ""
    var userImageURL: String = ""

    var localImage: UIImage? {
        get {
            guard let base64Image, let data = Data(base64Encoded: base64Image) else {
                return nil
            }
            return UIImage(data: data)
        }
        set {
            if let image = newValue, let data = image.jpegData(compressionQuality: 0.3) {
                base64Image = data.base64EncodedString()
            } else {
                base64Image = nil
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case makeNavigation
        case captionPost
        case id
        case uniqueID
        case postLike
        case postTime
        case base64Image
        case username
        case userImageURL
    }
}
