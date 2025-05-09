import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

class FeedViewModal: ObservableObject {

    @Published var userPosts: [FeedDataModal] = []
    @Published var universalPosts: [FeedDataModal] = []
    @Published var feedData = FeedDataModal()

    @Published var showPicker = false
    @Published var isUploading = false
    @Published var hasPostedBefore: Bool = false
    @Published var showingCamera = false
    @Published var errorMessage: String? = nil

    @Published var selectedDeviceImage: PhotosPickerItem? = nil {
        didSet {
            setPostImage(from: selectedDeviceImage)
        }
    }

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

    func uploadPostToFirebase(userId: String) {
        guard feedData.localImage != nil else {
            self.errorMessage = "No image selected."
            return
        }

        self.isUploading = true

        guard let base64Image = feedData.base64Image else {
            self.errorMessage = "Failed to convert image to base64."
            self.isUploading = false
            return
        }

        savePostToFirestore(userId: userId, base64Image: base64Image)
    }

    private func savePostToFirestore(userId: String, base64Image: String) {
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
            "base64Image": base64Image,
            "id": userId
        ]

        let db = Firestore.firestore()

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

    func fetchUserPostsAsync(userId: String) async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(userId)
                .collection("MyPosts")
                .order(by: "postTime", descending: true)
                .getDocuments()

            let posts = snapshot.documents.compactMap { decodePost(from: $0) }

            DispatchQueue.main.async {
                self.userPosts = posts
            }

        } catch {
            print("@Error fetching user posts async:", error)
        }
    }

    func fetchUniversalPostsAsync() async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("UniversalFeeds")
                .order(by: "postTime", descending: true)
                .getDocuments()

            let posts = snapshot.documents.compactMap { decodePost(from: $0) }

            DispatchQueue.main.async {
                self.universalPosts = posts
            }

        } catch {
            print("Error fetching universal posts async:", error)
        }
    }

    private func decodePost(from document: QueryDocumentSnapshot) -> FeedDataModal? {
        let data = document.data()

        guard let captionPost = data["captionPost"] as? String,
              let postLike = data["postLike"] as? Int,
              let timestamp = data["postTime"] as? Timestamp,
              let base64Image = data["base64Image"] as? String,
              let userId = data["id"] as? String else {
            return nil
        }

        return FeedDataModal(
            captionPost: captionPost,
            id: userId,
            uniqueID: document.documentID,
            postLike: postLike,
            postTime: timestamp.dateValue(),
            base64Image: base64Image
        )
    }

    func toggleLike(for post: FeedDataModal) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let index = userPosts.firstIndex(where: { $0.uniqueID == post.uniqueID }) else { return }

        let postRef = Firestore.firestore()
            .collection("users")
            .document(post.id)
            .collection("MyPosts")
            .document(post.uniqueID)

        let likeRef = postRef
            .collection("Likes")
            .document(currentUserId)

        likeRef.getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                postRef.updateData(["postLike": FieldValue.increment(Int64(-1))])
                likeRef.delete()
                DispatchQueue.main.async {
                    self.userPosts[index].postLike -= 1
                }
            } else {
                postRef.updateData(["postLike": FieldValue.increment(Int64(1))])
                likeRef.setData(["likedAt": Timestamp()])
                DispatchQueue.main.async {
                    self.userPosts[index].postLike += 1
                }
            }
        }
    }

}
