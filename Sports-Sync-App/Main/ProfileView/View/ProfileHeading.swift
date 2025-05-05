//
//  profileHeading.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct ProfileHeading: View {
    var body: some View {
        HStack{
            ReusableTexts(textString: .profileheadingString)
                .frame(width: 90 , height: 30,alignment: .center)
               
            
            Spacer().frame(width: 220)
            
            Image(systemName: "square.and.pencil")
                .resizable()
                .frame(width: 30, height: 30,alignment: .leading)
                .scaledToFit()
        }
       
       
    }
}

#Preview {
    ProfileHeading()
}
