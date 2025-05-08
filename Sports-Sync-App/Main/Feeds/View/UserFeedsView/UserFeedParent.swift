//
//  UserFeedView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

import SwiftUI

struct UserFeedParent: View {
    
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    var body: some View {
        VStack{
            PostCreationSection()
        }
        .environmentObject(firebaseValidation)
    }
}

#Preview {
    UserFeedParent()
        .environmentObject(FirebaseValidation())
}
