//
//  Trashbadge.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 01/05/25.
//

import SwiftUI

struct ReusableTrashBadgeButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "trash")
                .foregroundColor(.white)
                .padding(8)
                .background(Circle().fill(Color.black))
                .frame(width: 15, height: 25,alignment: .top)
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    ReusableTrashBadgeButton(action: {})
}
