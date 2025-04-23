//
//  EventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct EventView: View {
    private var imageConstants = ImageConstants()
    var body: some View {
        
        //image and text of event view
        VStack(spacing : 24){
            VStack(spacing : 15){
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
            
            //button view
            EventButton()
        }
    }
}

#Preview {
    EventView()
}
