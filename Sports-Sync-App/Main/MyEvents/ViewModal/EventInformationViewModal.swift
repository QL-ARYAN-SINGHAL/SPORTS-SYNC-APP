//
//  EventInformationViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
////
//var eventName = ""
//var eventDate = ""
//var sportsName = ""
//var eventTime = ""
import SwiftUI
import FirebaseFirestore

class EventInformationViewModal: ObservableObject {
    
    @Published var eventInfoData = EventInformationDataModal()
    
    let db = Firestore.firestore()
    //Function to store the create event information
    
    func eventInformationStoreDB(eventName : String , sportsName : String , eventDate : String, eventTime : String,state:String){
        
        db.collection("User Event").addDocument(data:
            
            [
                
                "Event Name " : eventName,
                "Sports Name " : sportsName,
                "Event Date " : eventDate,
                "Event Time " : eventTime,
                "State" : state
            
            ]
        )
    }
    
    func resetFields() {
           eventInfoData = EventInformationDataModal()
       }
    
}
