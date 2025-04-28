//
//  EventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct EventView: View {
  
    private var imageConstants = ImageConstants()
    @StateObject private var eventViewModal = EventViewModal()
    
    var body: some View {
        VStack(spacing: 0) {
            EventListView()
            
            Spacer()
            if !eventViewModal.eventDataModal.isViewHidden{
                VStack(spacing: 20) {
                    EventTextView()
                    
                    EventButton()
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .environmentObject(eventViewModal)
    }
}

#Preview {
    EventView()
}
