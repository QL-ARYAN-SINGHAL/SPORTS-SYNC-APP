//
//  ReusableNavBack.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//


//
//  ReusableNavBackImage.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ReusableNavBackImage: View {
    private var imageConstants = ImageConstants()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack{
          
          
        }
        .navigationBarCustombackButton(content:{
            Button(action : {dismiss() }, label: {
                imageConstants.navigationBackImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50 , height: 30)
                    
            })
        })
     
    }
    
}

extension View{
    func navigationBarCustombackButton<Content : View>(content : @escaping() -> Content) -> some View {
        self.navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                 content()
                }
            }
    }
}
#Preview {
    NavigationStack {
        ReusableNavBackImage()
    }
}
