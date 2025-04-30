//
//  EventInformation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//


import SwiftUI

struct EventInformationTitle: View {
    
    //Propertywrappers
    @Environment(\.dismiss) private var dismiss
    
    private let imageConstants = ImageConstants()
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Button(action: { dismiss() }) {
                    imageConstants.navigationBackImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 24)
                }
                
                Text(verbatim: .createEventString)
                    .font(Font.custom(.fontJakarta, size: 20))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            
        }
    }
}

#Preview {
    EventInformationTitle()
}
