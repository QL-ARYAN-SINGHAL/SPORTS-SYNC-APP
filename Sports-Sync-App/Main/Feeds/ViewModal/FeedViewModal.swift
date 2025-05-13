//MARK: - RESPONSIBILITY- SAVE THE DATA OF THE POST IN FIREBASE AND GET IT TOO, CHANGE THE PHOTO SELECTED IF USER WANT TO CHANGE , MANAGE THE LIKE COUNT OF EACH POST IN REAL TIME

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

class FeedViewModal: ObservableObject {

    /// ARRAYS COTAINING THE USER POST DETAILS AND USER DETAILS
    @Published var userPosts: [FeedDataModal] = []
    @Published var universalPosts: [FeedDataModal] = []
    @Published var feedData = FeedDataModal()

    ///States that are used in views
    @Published var showPicker = false
    @Published var isUploading = false
    @Published var hasPostedBefore: Bool = false
    @Published var showingCamera = false
    @Published var errorMessage: String? = nil

    ///image changer - when image changes in create post section
    @Published var selectedDeviceImage: PhotosPickerItem? = nil {
        didSet {
            setPostImage(from: selectedDeviceImage)
        }
    }
    


    //MARK: - function to set the image selected from gallery / camera on create post section
    private func setPostImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }

                await MainActor.run  {
                    self.feedData.localImage = uiImage
                }
            } catch {
                print("Error loading image from picker:", error)
            }
        }
    }

    //MARK: - Function to upload image in base64 format to firebase when user clicks on post button

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

    //MARK: -  function that saves post & details in firestore
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
                    self.errorMessage =
                    "Failed to save user post: \(error.localizedDescription)"
                }
            }
        
        db.collection("UniversalFeeds")
            .addDocument(data: postData) { error in
                if let error = error {
                    self.errorMessage =
                    "Failed to save universal post: \(error.localizedDescription)"
                }
                self.isUploading = false
                
            }
    }
    
    //MARK: -  pre check to confirm if user has post or not , if not then he wont be getting any posts
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

    //MARK: -  get user posts from databse to show on views
    func fetchUserPostsAsync(userId: String) async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(userId)
                .collection("MyPosts")
                .order(by: "postTime", descending: true)
                .getDocuments()

            let posts = snapshot.documents.compactMap { decodePost(from: $0) }
            
            

            await MainActor.run {
                self.userPosts = posts
            }

        } catch {
            print("@Error fetching user posts async:", error)
        }
    }


    //MARK: -  This fetches all the post , currentuser and other users
    func fetchUniversalPostsAsync() async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("UniversalFeeds")
                .order(by: "postTime", descending: true)
                .getDocuments()

            let posts = snapshot.documents.compactMap { decodePost(from: $0) }

            await MainActor.run  {
                self.universalPosts = posts
            }

        } catch {
            print("Error fetching universal posts async:", error)
        }
    }

    //MARK: - general function that decodes the data and image and are called by universal and user functions
    private func decodePost(from document: QueryDocumentSnapshot)
        -> FeedDataModal?
    {
        let data = document.data()

        guard let captionPost = data["captionPost"] as? String,
            let postLike = data["postLike"] as? Int,
            let timestamp = data["postTime"] as? Timestamp,
            let base64Image = data["base64Image"] as? String,
            let userId = data["id"] as? String
          
           
        else {
            return nil
        }
        let likedUsers = data["likedUsers"] as? [String] ?? []
        return FeedDataModal(
            captionPost: captionPost,
            id: userId,
            uniqueID: document.documentID,
            postLike: postLike,
            postTime: timestamp.dateValue(),
            base64Image: base64Image,
            likedUsers: likedUsers
        )
    }

    //MARK: - Manages to count of like , each id can have 1 like and if dislike then 0
    func toggleLike(for post: FeedDataModal) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let postRef = Firestore.firestore()
            .collection("UniversalFeeds")
            .document(post.uniqueID)
       
        postRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                var likeCount = data?["postLike"] as? Int ?? 0
                var likedUsers = data?["likedUsers"] as? [String] ?? []

                if likedUsers.contains(userId) {
                    likedUsers.removeAll { $0 == userId }
                    likeCount = max(0, likeCount - 1)
                } else {
                    likedUsers.append(userId)
                    likeCount += 1
                }

                postRef.updateData([
                    "postLike": likeCount,
                    "likedUsers": likedUsers
                ]) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            // Refresh the universal feed
                            Task {
                                await self.fetchUniversalPostsAsync()
                                await self.fetchUserPostsAsync(userId: userId)
                            }
                        }
                    }
                }
            }
        }
    }



    //MARK: - FUNCTION TO DELETE USER POST FROM FIREBASE AND FROM UI
    
    func deleteUserPost(post: FeedDataModal) {
            guard let currentUserId = Auth.auth().currentUser?.uid else {
                print("No user logged in")
                return
            }

            guard post.id == currentUserId else {
                print("User is not the owner of this post")
                return
            }

            let db = Firestore.firestore()
            
            // Start a batch write operation for atomic updates
            let batch = db.batch()
            
           
            let userPostRef = db
                .collection("users")
                .document(currentUserId)
                .collection("MyPosts")
                .document(post.uniqueID)
            
           
            batch.deleteDocument(userPostRef)
            
           
            db.collection("UniversalFeeds")
                .whereField("id", isEqualTo: post.id)
                .whereField("captionPost", isEqualTo: post.captionPost)
                .getDocuments { querySnapshot, error in
                    
                    if let error = error {
                        print("Error finding universal post: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                        print("No matching universal post found")
                        
                     
                        batch.commit { error in
                            if let error = error {
                                print("Error deleting user post: \(error.localizedDescription)")
                            } else {
                                print("User post deleted successfully")
                                
                               
                                DispatchQueue.main.async {
                                    self.userPosts.removeAll { $0.uniqueID == post.uniqueID }
                                }
                            }
                        }
                        return
                    }
                    
                    // Add each matching universal post to the batch delete operation
                    for document in documents {
                        batch.deleteDocument(document.reference)
                        print("Adding universal post \(document.documentID) to batch delete")
                    }
                    
                    // Commit the batch operation
                    batch.commit { error in
                        if let error = error {
                            print("Error in batch delete: \(error.localizedDescription)")
                        } else {
                            print("All posts deleted successfully")
                            
                            // Update UI
                            DispatchQueue.main.async {
                                self.userPosts.removeAll { $0.uniqueID == post.uniqueID }
                                
                                // For universal posts, we need to match by content since the ID might be different
                                self.universalPosts.removeAll {
                                    $0.id == post.id &&
                                    $0.captionPost == post.captionPost &&
                                    $0.base64Image == post.base64Image
                                }
                            }
                        }
                    }
                }
        }

}
