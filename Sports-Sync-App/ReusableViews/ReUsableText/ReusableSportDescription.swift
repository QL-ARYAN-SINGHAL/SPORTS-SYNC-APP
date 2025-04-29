//
//  ReusableSportDescription.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct ReusableSportDescription: View {
    var eventHeading : String
    var eventInfo : String
    var body: some View {
        VStack{
            Text(eventHeading)
                .font(Font.custom(.fontJakarta, size: 15))
                .foregroundStyle(.font)
                .frame(width: 343,height: 20,alignment: .leading)
            Text(eventInfo)
                .font(Font.custom(.fontJakartaBold, size: 15))
                .frame(width: 343 , height: 20,alignment: .leading)
        }
    }
}

#Preview {
    ReusableSportDescription(eventHeading: "Date event", eventInfo: "5 october 2025")
}
