//
//  EventInformationViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
////

import SwiftUI
import FirebaseFirestore

class EventInformationViewModal: ObservableObject {
    
    @Published var eventInfoData = EventInformationDataModal()
    @Published var didSubmitSuccessfully = false
    
    let db = Firestore.firestore()
    //Function to store the create event information
    
    func eventInformationStoreDB(eventName : String , sportsName : String , eventDate : String, eventTime : String,state:String,selectedStadium : String){
        
        db.collection("User Event").addDocument(data:
            
            [
                
                "Event Name " : eventName,
                "Sports Name " : sportsName,
                "Event Date " : eventDate,
                "Event Time " : eventTime,
                "State" : state,
                "Selected Stadium" : selectedStadium
            
            ]
        )
        didSubmitSuccessfully = true
    }
    
    func resetFields() {
           eventInfoData = EventInformationDataModal()
       }
    
    func checkValidation() -> Bool {
        return !eventInfoData.eventName.isEmpty && !eventInfoData.sportsName.isEmpty && !eventInfoData.eventDate.isEmpty && !eventInfoData.eventTime.isEmpty && eventInfoData.selectedStadium != nil
    }
    
}
