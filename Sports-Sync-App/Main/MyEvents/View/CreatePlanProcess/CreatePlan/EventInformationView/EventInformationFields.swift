//
//  EventInformationFields.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationFields: View {
    
    @EnvironmentObject var eventInformationViewModel: EventInformationViewModal
    @EnvironmentObject var tabRouter: TabRouter
    
    @State private var currentMonth = Date.now
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var showAlert = false
    
    @State private var navigateToRoot = false
    
    var selectedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text(verbatim: .otherDetailString)
                .font(Font.custom(.fontJakartaBold, size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 17)
            
            VStack(spacing: 16) {
                FormTextfields(textField: $eventInformationViewModel.eventInfoData.eventName, placeholder: .eventNameString)
                FormTextfields(textField: $eventInformationViewModel.eventInfoData.sportsName, placeholder: .sportsNameString)
                
                ZStack(alignment: .trailing) {
                    FormTextfields(textField: $eventInformationViewModel.eventInfoData.eventDate, placeholder: .eventDateString)
                        .disabled(true)
                        .onTapGesture {
                            withAnimation { showDatePicker.toggle() }
                        }
                    
                    Button(action: {
                        withAnimation { showDatePicker.toggle() }
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.appTint)
                            .padding(.trailing, 8)
                    }
                }
                
                if showDatePicker {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
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
                            .frame(width: 20, height: 20)
                            .foregroundColor(.appTint)
                            .padding(.trailing, 8)
                    }
                }
                
                if showTimePicker {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .onChange(of: selectedTime) { newTime in
                            let formatter = DateFormatter()
                            formatter.timeStyle = .short
                            eventInformationViewModel.eventInfoData.eventTime = formatter.string(from: newTime)
                        }
                }
            }
            
            Spacer()
            
            ActivatedButton(buttonText: .createPlanString) {
                if eventInformationViewModel.checkValidation() {
                    eventInformationViewModel.eventInformationStoreDB(
                        eventName: eventInformationViewModel.eventInfoData.eventName,
                        sportsName: eventInformationViewModel.eventInfoData.sportsName,
                        eventDate: eventInformationViewModel.eventInfoData.eventDate,
                        eventTime: eventInformationViewModel.eventInfoData.eventTime,
                        state: eventInformationViewModel.eventInfoData.searchText,
                        selectedStadium: eventInformationViewModel.eventInfoData.selectedStadium ?? "Failed to get stadium name!"
                    )
                    if eventInformationViewModel.didSubmitSuccessfully {
                        tabRouter.tabDataModal.selectedTab = 1
                        navigateToRoot = true
                    }
                    eventInformationViewModel.resetFields()
                    selectedDate = Date()
                    selectedTime = Date()
                    showDatePicker = false
                    showTimePicker = false
                    eventInformationViewModel.eventInfoData.selectedStadium = nil
                    
                }
               
                else {
                    showAlert = true
                }
                
              
            }
        }
        .padding(.horizontal)
        .navigationDestination(isPresented: $navigateToRoot) {
            MainTabView()
                .onAppear {
                    tabRouter.tabDataModal.selectedTab = 2
                }
        }
        .alert("Please fill out all the fields.", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
       

}
#Preview {
    EventInformationFields()
        .environmentObject(EventInformationViewModal())
        .environmentObject(TabRouter())
}


