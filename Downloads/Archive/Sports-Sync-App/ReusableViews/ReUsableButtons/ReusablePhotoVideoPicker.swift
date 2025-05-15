
//  PhotoVideoPicker.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct ReusablePhotoVideoPicker: View {
    let iconName: String
    let labelText: String
    
    
    var body: some View {
        
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .tint(.black)
                
                Text(labelText)
                    .font(Font.custom(.fontJakarta, size: 12))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
        
       
    }
}
#Preview {
    ReusablePhotoVideoPicker(iconName : "camera.fill",labelText: "camera")
}
