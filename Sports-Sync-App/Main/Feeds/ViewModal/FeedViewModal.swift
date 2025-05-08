import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

class FeedViewModal: ObservableObject {
    @Published var feedData = FeedDataModal()  // Holds the current post data
    @Published var showPicker = false
    @Published var isUploading = false
    @Published var errorMessage: String? = nil  // To show error messages
    @Published var showingCamera = false
    @Published var hasPostedBefore: Bool = false
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

    
    
    //MARK: To save user postdetails in firebase

    func uploadPostToFirebase(userId: String) {
        guard let image = feedData.localImage else {
            self.errorMessage = "No image selected."
            return
        }

        self.isUploading = true

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            self.errorMessage = "Failed to compress image."
            self.isUploading = false
            return
        }

        let imageID = UUID().uuidString
        let fileName = "\(imageID).jpg"

        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        do {
            try imageData.write(to: fileURL)
            print("Image saved locally at:", fileURL.path)
            self.savePostToFirestore(userId: userId, imagePath: fileURL.path)
        } catch {
            self.errorMessage =
                "Failed to save image locally: \(error.localizedDescription)"
            self.isUploading = false
        }
    }

     private func savePostToFirestore(userId: String, imagePath: String) {
        guard let userSession = FirebaseAuth.Auth.auth().currentUser else {
            self.errorMessage = "User not authenticated."
            self.isUploading = false
            return
        }

        if userSession.uid != userId {
            self.errorMessage = "User ID mismatch."
            self.isUploading = false
            return
        }

        let postData: [String: Any] = [
            "captionPost": feedData.captionPost,
            "postLike": feedData.postLike,
            "postTime": Timestamp(date: feedData.postTime),
            "imageLocalPath": imagePath,
            "userId": userId
        ]

        let db = Firestore.firestore()

      //For personal feeds to show
         
        db.collection("users")
            .document(userId)
            .collection("MyPosts")
            .addDocument(data: postData) { error in
                if let error = error {
                    self.errorMessage = "Failed to save user post: \(error.localizedDescription)"
                } else {
                    print(" User post uploaded successfully.")
                }
            }

    //   For universal collection of feeds to be shown
        db.collection("UniversalFeeds")
            .addDocument(data: postData) { error in
                if let error = error {
                    self.errorMessage = "Failed to save universal post: \(error.localizedDescription)"
                } else {
                    print(" Universal post uploaded successfully.")
                }
                self.isUploading = false
            }
    }
   
// to check if user has any post or not 
    func checkIfUserHasPosts(userId: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("MyPosts")
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error checking posts:", error)
                    self.hasPostedBefore = false
                    return
                }
                
                if let documents = snapshot?.documents, !documents.isEmpty {
                    self.hasPostedBefore = true
                } else {
                    self.hasPostedBefore = false
                }
            }
    }

}
