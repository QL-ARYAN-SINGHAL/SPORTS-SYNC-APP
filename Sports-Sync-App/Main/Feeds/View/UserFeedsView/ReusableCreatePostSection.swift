//
//  ReusableCreatePostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

import SwiftUI

struct ReusableCreatePostSection: View {
    var body: some View {
        VStack{
            Text("hello user ")
            
            HStack{
                Reusable
            }
        }
        .frame(width: 343 , height : 74)
    }
}

#Preview {
    ReusableCreatePostSection()
}
