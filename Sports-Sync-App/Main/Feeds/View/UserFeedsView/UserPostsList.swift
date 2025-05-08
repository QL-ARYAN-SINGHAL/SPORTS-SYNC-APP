//
//  UserPostsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

import SwiftUI

struct UserPostsList: View {
    
    @EnvironmentObject var feedViewModal : FeedViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    var body: some View {
        VStack(spacing : 15){
            if let user = firebaseValidation.currentUser{
                
                
                ReusablePostListHeader( userName: user.firstName, postTime: Date(),userImage: firebaseValidation.avatarImage) //time would be fetched  from firebstore
                
                
                ReusablePostListMid(postCaption: "hello")//here the post image would be fetched and siaplyed
                
                
                ReusablePostListFooter(commentCount: 20, likeCount: 5,likeAction: {},commentAction: {},shareAction: {}) //likes here will be etched 
            }
    }
        .frame(width: 343 , height : 356)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.disabledButton,lineWidth: 0.5)
        )
        .environmentObject(firebaseValidation)
        .environmentObject(feedViewModal)
    }
}

#Preview {
    UserPostsList()
        .environmentObject(FirebaseValidation())
       
}
