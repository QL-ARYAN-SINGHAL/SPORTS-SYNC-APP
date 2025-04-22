//
//  WelcomingImage.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct WelcomingImage: View {
       //MARK: INSTANCES
    private var imageConstants = ImageConstants()
    var body: some View {
        imageConstants.welcomeBikeImage
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    WelcomingImage()
}
