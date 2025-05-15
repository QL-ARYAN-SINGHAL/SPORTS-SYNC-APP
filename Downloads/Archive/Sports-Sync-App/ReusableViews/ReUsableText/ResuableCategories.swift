//
//  ResuableCategories.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

//
//  ResuableCategories.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

//
//  ReusableCategories.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct ReusableCategories: View {
    let categorytext: String
    let imageName: String

    var body: some View {
        HStack(spacing: 5) {
            Text(categorytext)
                .font(Font.custom(.fontJakartaBold, size: 14))
                
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
        }
        .foregroundColor(.appTint)
        
        .frame(width: 89, height: 40)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.appTint, lineWidth: 1)
        )
    }
}

#Preview {
    ReusableCategories(categorytext: "September", imageName: "calendar")
}
