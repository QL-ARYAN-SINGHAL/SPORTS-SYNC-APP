//
//  EventInformationFields.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationFields: View {
    
    @EnvironmentObject var eventInformationViewModel : EventInformationViewModal
    
    @State private var currentMonth = Date.now
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()

    var selectedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text(verbatim: .otherDetailString)
                .font(Font.custom(.fontJakartaBold, size: 18))
                .frame(width: 343, height: 20, alignment: .leading)
            
            VStack(spacing: 16) {
                FormTextfields(textField: $eventInformationViewModel.eventInfoData.eventName, placeholder: .eventNameString)
                FormTextfields(textField: $eventInformationViewModel.eventInfoData.sportsName, placeholder: .sportsNameString)
                
                ZStack(alignment: .trailing) {
                    FormTextfields(textField: $eventInformationViewModel.eventInfoData.eventDate, placeholder: .eventDateString)
                        .disabled(true)
                        .onTapGesture {
                            withAnimation {
                                showDatePicker.toggle()
                            }
                        }
                    
                    Button(action: {
                        withAnimation {
                            showDatePicker.toggle()
                        }
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 12)
                            .foregroundColor(.appTint)
                    }
                }
                
                if showDatePicker {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .onChange(of: selectedDate) { newDate in
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        eventInformationViewModel.eventInfoData.eventDate = formatter.string(from: newDate)
                    }
                }

                ZStack(alignment: .trailing) {
                    FormTextfields(textField: $eventInformationViewModel.eventInfoData.eventTime, placeholder: .eventTimeString)
                        .disabled(true)
                        .onTapGesture {
                            showTimePicker.toggle()
                        }
                    
                    Button(action: {
                        showTimePicker.toggle()
                    }) {
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 12)
                            .foregroundColor(.appTint)
                    }
                }

                if showTimePicker {
                    DatePicker(
                        "",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .onChange(of: selectedTime) {
                        newTime in
                        
                        let formatter = DateFormatter()
                        
                        formatter.timeStyle = .short
                        
                    eventInformationViewModel.eventInfoData.eventTime = formatter.string(from: newTime)
                    }
                }
            }

            Spacer()

            ActivatedButton(buttonText: .createPlanString) {
                eventInformationViewModel.eventInformationStoreDB(
                    eventName: eventInformationViewModel.eventInfoData.eventName,
                    sportsName: eventInformationViewModel.eventInfoData.sportsName,
                    eventDate: eventInformationViewModel.eventInfoData.eventDate,
                    eventTime: eventInformationViewModel.eventInfoData.eventTime,
                    state: eventInformationViewModel.eventInfoData.searchText,
                    selectedStadium: eventInformationViewModel.eventInfoData.selectedStadium ?? "Failed to get stadium name !"
                    
                )
                
                //function call to reset fields after the information is stored in db
                eventInformationViewModel.resetFields()
                
                selectedDate = Date()
                selectedTime = Date()
                showDatePicker = false
                showTimePicker = false
                
            }
        }
    }
}

#Preview {
    EventInformationFields()
        .environmentObject(EventInformationViewModal())
}
