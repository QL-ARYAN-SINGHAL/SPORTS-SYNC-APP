//
//  ReusableCreatePostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//

import SwiftUI

struct PostCreationSection: View {
    
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    var body: some View {
        VStack{
            if let user = firebaseValidation.currentUser{
                Text("What's on your mind ,\(user.firstName) ?")
                    .font(Font.custom(.fontJakarta, size: 15))
                    .frame(width: 343 , height : 39,alignment:.leading)
                    .foregroundStyle(.disabledFont)
            }else{
                Text("What's on your mind ?")
                    .font(Font.custom(.fontJakarta, size: 15))
                    .frame(width: 343 , height : 39,alignment:.leading)
                    .foregroundStyle(.disabledFont)
            }
           
            HStack{
                
                ReusablePhotoVideoPicker(iconName: "camera.fill", labelText: .cameraString)
                
                ReusablePhotoVideoPicker(iconName: "photo.fill.on.rectangle.fill", labelText: .photoVideoString)
                
            }
            .frame(width: 343 , height : 40,alignment: .leading)
            
        }
        .frame(width: 343 , height : 74)
    }
}

#Preview {
    PostCreationSection()
}
