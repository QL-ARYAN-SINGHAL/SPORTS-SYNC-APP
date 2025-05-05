//
//  FeedTextView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

//
//  EventTextView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct FeedTextView: View {
    private var imageConstants = ImageConstants()
    @EnvironmentObject var feedViewModal : FeedViewModal
    
    var body: some View {
        VStack(spacing: 15) {
           
            imageConstants.feedDefaultImage
                    .resizable()
            
                    .scaledToFit()
                    .frame(width: 106, height: 67)
                
            Text(verbatim: .feedMessage)
                    .font(Font.custom(.fontJakarta, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.shadowtext)
                    .frame(width: 320)
            }
        
    }
}

#Preview {
    FeedTextView()
        .environmentObject(FeedViewModal())
}
