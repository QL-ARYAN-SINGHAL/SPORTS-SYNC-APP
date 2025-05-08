//
//  FeedDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
import SwiftUI

struct FeedDataModal: Codable {
    var makeNavigation: Bool = false
    var captionPost: String = ""
    var id: String = ""
    var postLike: Int = 0
    var postTime: Date = Date()
    
    // Not Codable
    var localImage: UIImage? = nil

    enum CodingKeys: String, CodingKey {
        case makeNavigation
        case captionPost
        case id
        case postLike
        case postTime
        // Exclude localImage from coding
    }
}
