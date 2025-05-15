//
//  ReusablePhotoPicker.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct ReusablePhotoPicker: View {
    
    var imageName : String = ""
    var action : () -> Void
    var buttonText : String = ""
    
    
    var body: some View {
        Button(action : action ){
            HStack{
                Image(imageName )
                    .resizable()
                    .scaledToFit()
                    
                
                Text(buttonText)
                    .frame(width: 46 , height: 15)
                    .font(Font.custom(.fontJakarta, size: 12))
                    .foregroundStyle(.disabledFont)
            }
            .frame(width: 89 , height : 35)
        }
    }
}

#Preview {
    ReusablePhotoPicker(imageName: "camera", action: {},buttonText: "Camera")
}
