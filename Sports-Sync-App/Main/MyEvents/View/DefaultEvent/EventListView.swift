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
    @State private var selectedWeekStartDate: Date? = nil
    @EnvironmentObject var eventViewModal: EventInformationViewModal

    let weeks = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"]

    var selectedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }

    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ReusableCategories(
                        categorytext: selectedMonth, imageName: "calendar"
                    )
                    .onTapGesture {
                        eventViewModal.eventDataModal.isViewHidden.toggle()
                        showDatePicker.toggle()
                    }

                    ForEach(0..<weeks.count, id: \.self) { index in
                        let startOfMonth = currentMonth.startOfMonth
                        
                        let weekStart = Calendar.current.date(
                            byAdding: .day, value: index * 7, to: startOfMonth)!

                        ReusableListButtons(
                            buttonText: weeks[index],
                            isSelected: selectedWeekStartDate == weekStart
                        ) {
                            selectedWeekStartDate = weekStart
                            eventViewModal.filterEvents(for: weekStart)
                        }
                        .padding(10)
                    }
                }
                .padding(.leading, 8)
            }

            if showDatePicker {
                DatePicker(
                    "Select Date", selection: $currentMonth,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
        }
    }
}

extension Date {
    var startOfMonth: Date {
        Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}

#Preview {
    EventListView()
}
