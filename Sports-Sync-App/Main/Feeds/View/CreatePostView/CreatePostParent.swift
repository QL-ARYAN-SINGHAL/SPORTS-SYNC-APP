//
//  CreatePostParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct CreatePostParent: View {
    @StateObject var feedViewModal = FeedViewModal()
    var body: some View {
        NavigationStack {

            CreatePostHeading()

            PostSection()

            Spacer()

            PhotoVideoPickerFooter()

                .navigationBarBackButtonHidden()
        }
        .environmentObject(feedViewModal)
    }
}

#Preview {
    CreatePostParent()
}
