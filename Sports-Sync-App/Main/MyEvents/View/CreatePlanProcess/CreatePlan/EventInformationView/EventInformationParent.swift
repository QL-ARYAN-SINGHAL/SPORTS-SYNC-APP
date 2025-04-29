//
//  EventInformationParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationParent: View {
    var body: some View {
        
        VStack{
            EventInformation()
            ScrollView{
                EventInformationFields()
            }
        }
    }
}

#Preview {
    EventInformationParent()
}
