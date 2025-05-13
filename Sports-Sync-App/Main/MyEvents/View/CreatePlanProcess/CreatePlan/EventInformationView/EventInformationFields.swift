import SwiftUI

struct EventInformationFields: View {

    @EnvironmentObject var eventInformationViewModel: EventInformationViewModal
    @EnvironmentObject var tabRouter: TabRouter
    @EnvironmentObject var firebaseValidation: FirebaseValidation
     
    @State private var navigateBackToMain: Bool = false
    @State private var currentMonth = Date.now
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var showAlert = false

    var selectedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text(verbatim: .otherDetailString)
                    .font(Font.custom(.fontJakartaBold, size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 17)
                
                VStack(spacing: 16) {
                    FormTextfields(
                        textField: $eventInformationViewModel.eventInfoData
                            .eventName,
                        placeholder: .eventNameString
                    )
                    
                    FormTextfields(
                        textField: $eventInformationViewModel.eventInfoData
                            .sportsName,
                        placeholder: .sportsNameString
                    )
                    
                    ZStack(alignment: .trailing) {
                        FormTextfields(
                            textField: $eventInformationViewModel.eventInfoData
                                .eventDate,
                            placeholder: .eventDateString
                        )
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
                        DatePicker(
                            "", selection: $selectedDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .onChange(of: selectedDate) { newDate in
                            let formatter = DateFormatter()
                            formatter.dateStyle = .medium
                            eventInformationViewModel.eventInfoData.eventDate =
                            formatter.string(from: newDate)
                        }
                    }
                    
                    ZStack(alignment: .trailing) {
                        FormTextfields(
                            textField: $eventInformationViewModel.eventInfoData
                                .eventTime,
                            placeholder: .eventTimeString
                        )
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
                        DatePicker(
                            "", selection: $selectedTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .onChange(of: selectedTime) { newTime in
                            let formatter = DateFormatter()
                            formatter.timeStyle = .short
                            eventInformationViewModel.eventInfoData.eventTime =
                            formatter.string(from: newTime)
                        }
                    }
                }
                
                Spacer()
                
                ActivatedButton(buttonText: .createPlanString) {
                    if eventInformationViewModel.checkValidation() {
                        eventInformationViewModel.isSubmitting = true
                        eventInformationViewModel.eventInformationStoreDB(
                            id: firebaseValidation.currentUser?.id ?? "id",
                            eventName: eventInformationViewModel.eventInfoData
                                .eventName,
                            sportsName: eventInformationViewModel.eventInfoData
                                .sportsName,
                            eventDate: eventInformationViewModel.eventInfoData
                                .eventDate,
                            eventTime: eventInformationViewModel.eventInfoData
                                .eventTime,
                            state: eventInformationViewModel.eventInfoData
                                .searchText,
                            selectedStadium: eventInformationViewModel
                                .eventInfoData.selectedStadium
                            ?? "Failed to get stadium name!"
                        )
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            if eventInformationViewModel.didSubmitSuccessfully {
                                Task {
                                    await eventInformationViewModel
                                        .getUserCreatedEvent()
                                    
                                    DispatchQueue.main.async {
                                        eventInformationViewModel.resetFields()
                                        selectedDate = Date()
                                        selectedTime = Date()
                                        showDatePicker = false
                                        showTimePicker = false
                                        eventInformationViewModel.eventInfoData
                                            .selectedStadium = nil
                                        
                                        
                                        tabRouter.tabDataModal.selectedTab = 1 // Set the selected tab to 1
                                        
                                        eventInformationViewModel.isSubmitting = false
                                        navigateBackToMain = true
                                    }
                                }
                            } else {
                                eventInformationViewModel.isSubmitting = false
                            }
                        }
                        
                    } else {
                        showAlert = true
                    }
                }
            }
            .padding(.horizontal)
            .disabled(eventInformationViewModel.isSubmitting)
            .alert("Please fill out all the fields.", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }

            // NavigationLink with isActive
            NavigationLink(
                destination: MainTabView() // Replace with the correct destination view
                    .environmentObject(tabRouter),
                isActive: $navigateBackToMain
            ) {
                EmptyView()
            }
            .hidden()
        }
    }
}

#Preview {
    EventInformationFields()
        .environmentObject(EventInformationViewModal())
        .environmentObject(TabRouter())
        .environmentObject(FirebaseValidation())
}
