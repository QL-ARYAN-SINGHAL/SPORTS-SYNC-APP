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
    }
    
    func resetFields() {
           eventInfoData = EventInformationDataModal()
       }
    
}
