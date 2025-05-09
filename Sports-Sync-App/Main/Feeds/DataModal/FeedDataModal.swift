//
//  FeedDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
import SwiftUI

struct FeedDataModal: Identifiable, Codable {
    var makeNavigation: Bool = false
    var captionPost: String = ""
    var id: String = ""
    var postLike: Int = 0
    var postTime: Date = Date()
    
    // This will store base64 encoded image string (for Firebase)
    var base64Image: String? = nil

    // Computed property to convert base64 string to UIImage
    var localImage: UIImage? {
        get {
            guard let base64Image, let data = Data(base64Encoded: base64Image) else {
                return nil
            }
            return UIImage(data: data)
        }
        set {
            if let image = newValue, let data = image.jpegData(compressionQuality: 0.2) {
                base64Image = data.base64EncodedString()
                print("Base64 length: \(base64Image?.count ?? 0)")

            } else {
                base64Image = nil
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case makeNavigation
        case captionPost
        case id
        case postLike
        case postTime
        case base64Image
    }
}
