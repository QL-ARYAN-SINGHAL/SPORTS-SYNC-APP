//
//  UserFeedView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

//MARK: RESPONSIBILITY : - SHOW USER POSTS AND OPTION TO CREATE A NEW POST IF USER HAS ANY POST EVEN 1

import SwiftUI

struct UserFeedParent: View {
    @State private var selectedOption: String = "General"
    @EnvironmentObject var feedViewModal: FeedViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        List {
            VStack(spacing: 10) {
                UserPostCreationSection()

                // Dropdown aligned to the right
                HStack {
                    Spacer()
                    UserDropdownMenu(selectedOption: $selectedOption)
                }

                // Filtered feed based on dropdown
                UserFeedScrollList(selectedOption: selectedOption)
                    .environmentObject(feedViewModal)
                    .environmentObject(firebaseValidation)
            }
            .padding()
        }
        .onAppear {
            Task {
                await feedViewModal.fetchUniversalPostsAsync()
                if let uid = firebaseValidation.userSession?.uid {
                    await feedViewModal.fetchUserPostsAsync(userId: uid)
                }
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    UserFeedParent()
        .environmentObject(FirebaseValidation())
        .environmentObject(FeedViewModal())
}
