//
//  FeedButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct FeedButton: View {
    @EnvironmentObject var feedViewModal : FeedViewModal
    
    var body: some View {
        
            Button(action: {
                feedViewModal.feedData.makeNavigation = true
            }) {
                Text(verbatim: .feedButtonMessage)
                    .font(Font.custom(.fontJakartaBold, size: 12))
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.appTint)
                    )
            }
          
            .navigationDestination(isPresented: $feedViewModal.feedData.makeNavigation) {
                CreatePostParent()
            }
        }
  
}

#Preview {
    FeedButton()
        .environmentObject(FeedViewModal())
}
