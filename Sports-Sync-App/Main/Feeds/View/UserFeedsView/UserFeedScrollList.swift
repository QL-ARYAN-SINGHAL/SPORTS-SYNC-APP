//
//  UserFeedScrollList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//
import SwiftUI

struct UserFeedScrollList: View {
    @EnvironmentObject var feedViewModal: FeedViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation
    @Binding var selectedOption: String


    var filteredPosts: [FeedDataModal] {
        switch selectedOption {
        case "My Feed":
            return feedViewModal.userPosts.filter {
                $0.id == firebaseValidation.currentUser?.id
            }
        case "General":
            return feedViewModal.universalPosts
        default:
            return feedViewModal.userPosts
        }
    }

    var body: some View {
        List {
            HStack {
                Spacer()
                UserDropdownMenu(selectedOption: $selectedOption)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.none)

            if filteredPosts.isEmpty {
                Text("No posts to show.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.none)
            } else {
                ForEach(filteredPosts, id: \.uniqueID) { post in
                    UserPostsList(post: post, selectedOption: $selectedOption)  // Pass selectedOption here
                        .environmentObject(firebaseValidation)
                        .environmentObject(feedViewModal)
                        .frame(maxWidth: .infinity)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                        .background(Color.clear)
                }
            }
        }
        .listStyle(.plain)
        .buttonStyle(PlainButtonStyle())
    }
}

