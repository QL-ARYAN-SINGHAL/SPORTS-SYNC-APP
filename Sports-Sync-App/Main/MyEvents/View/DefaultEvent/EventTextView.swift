//
//  EventTextView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct EventTextView: View {
    private var imageConstants = ImageConstants()
   
    
    var body: some View {
        VStack(spacing: 15) {
           
                imageConstants.emptyBoxImage
                    .resizable()
            
                    .scaledToFit()
                    .frame(width: 106, height: 67)
                
                Text(verbatim: .eventViewMessage)
                    .font(Font.custom(.fontJakarta, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.shadowtext)
                    .frame(width: 300)
            }
        
    }
}

#Preview {
    EventTextView()
}
