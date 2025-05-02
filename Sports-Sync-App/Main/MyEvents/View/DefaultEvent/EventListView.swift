//
//  EventListView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//


import SwiftUI

struct EventListView: View {
    @State private var currentMonth = Date.now
    @State private var showDatePicker = false
    @EnvironmentObject var eventViewModal : EventInformationViewModal
   
    
    let weeks = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", "Week 7"]

    var selectedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }

    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ReusableCategories(categorytext: selectedMonth, imageName: "calendar")
                        .onTapGesture {
                            eventViewModal.eventDataModal.isViewHidden.toggle()
                                showDatePicker.toggle()
                        }

                    ForEach(weeks, id: \.self) { week in
                        ReusableListButtons(buttonText: week, action: {})
                            .padding(10)
                    }
                }
                .padding(.leading , 8)
            }
           
            if showDatePicker {
                DatePicker("Select Date", selection: $currentMonth, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    
            }
        }
        
    }
}

#Preview {
    EventListView()
}
