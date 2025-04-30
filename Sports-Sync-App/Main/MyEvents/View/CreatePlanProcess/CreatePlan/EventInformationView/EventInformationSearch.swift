//
//  EventInformationSearch.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationSearch: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                print("Select Location on Map tapped")
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "paperplane.fill")
                        .frame(width: 13 , height: 13)
                    
                    Text("Select Location on Map")
                        .font(Font.custom(.fontJakarta, size: 14))
                        .frame(width: 161, height: 23, alignment: .center)
                }
                .frame(width: 351, height: 23, alignment: .leading)
            }

            Spacer()
        }
        .padding(.top, 8)
    }
}

#Preview {
    NavigationView {
        EventInformationSearch()
    }
}
