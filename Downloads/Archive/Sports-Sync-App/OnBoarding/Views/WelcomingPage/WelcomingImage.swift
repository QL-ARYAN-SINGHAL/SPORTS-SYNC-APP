//
//  WelcomingImage.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct WelcomingImage: View {
       //MARK: INSTANCES
   
    var body: some View {
        ImageConstants.welcomeBikeImage
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    WelcomingImage()
}
