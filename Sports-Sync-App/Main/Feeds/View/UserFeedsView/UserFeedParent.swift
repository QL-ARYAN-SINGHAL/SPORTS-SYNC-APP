//
//  UserFeedView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

//MARK: RESPONSIBILITY : - SHOW USER POSTS AND OPTION TO CREATE A NEW POST IF USER HAS ANY POST EVEN 1

import SwiftUI
struct UserFeedParent: View {
    
    @EnvironmentObject var feedViewModal : FeedViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    var body: some View {
        ScrollView{
            VStack(spacing : 15){
                
                UserPostCreationSection()
                
                UserPostsList()
            }
            .environmentObject(firebaseValidation)
            .environmentObject(feedViewModal)
            
        }
        .scrollIndicators(.hidden)
    }
}
#Preview {
    UserFeedParent()
        .environmentObject(FirebaseValidation())
}
