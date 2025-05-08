import Foundation
import _PhotosUI_SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import SwiftUI

class FeedViewModal: ObservableObject {
    @Published var feedData = FeedDataModal()  // Holds the current post data
    @Published var showPicker = false
    @Published var isUploading = false
    @Published var errorMessage: String? = nil  // To show error messages
    @Published var showingCamera = false
    @Published var selectedDeviceImage: PhotosPickerItem? = nil {
        didSet {
            setPostImage(from: selectedDeviceImage)
        }
    }

    // Function to set the image selected from the picker
    private func setPostImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }

                DispatchQueue.main.async {
                    self.feedData.localImage = uiImage
                }
            } catch {
                print("Error loading image from picker:", error)
            }
        }
    }

    // Function to upload the post to Firebase
    func uploadPostToFirebase(userId: String) {
        guard let image = feedData.localImage else {
            self.errorMessage = "No image selected."
            return
        }
        
        self.isUploading = true

        // Compress the image
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            self.errorMessage = "Failed to compress image."
            self.isUploading = false
            return
        }

        let imageID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("postImages/\(imageID).jpg")

        storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            guard let self else { return }

            if let error = error {
                self.errorMessage = "Failed to upload image: \(error.localizedDescription)"
                self.isUploading = false
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    self.errorMessage = "Failed to get download URL: \(error.localizedDescription)"
                    self.isUploading = false
                    return
                }

                guard let url = url else {
                    self.errorMessage = "Failed to get download URL."
                    self.isUploading = false
                    return
                }

                self.savePostToFirestore(userId: userId, imageURL: url.absoluteString)
            }
        }
    }

    private func savePostToFirestore(userId: String, imageURL: String) {
        guard let userSession = FirebaseAuth.Auth.auth().currentUser else {
            self.errorMessage = "User not authenticated."
            self.isUploading = false
            return
        }

        // Ensure user ID is the authenticated user
        if userSession.uid != userId {
            self.errorMessage = "User ID mismatch."
            self.isUploading = false
            return
        }

        let postData: [String: Any] = [
            "captionPost": feedData.captionPost,
            "postLike": feedData.postLike,
            "postTime": Timestamp(date: feedData.postTime),
            "imageURL": imageURL
        ]

        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("MyPosts")
            .addDocument(data: postData) { error in
                if let error = error {
                    self.errorMessage = "Failed to save post: \(error.localizedDescription)"
                } else {
                    print("Post uploaded successfully.")
                }
                self.isUploading = false
            }
    }
}
