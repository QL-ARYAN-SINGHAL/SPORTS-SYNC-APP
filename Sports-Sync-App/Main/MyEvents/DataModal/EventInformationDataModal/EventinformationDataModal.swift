//
//  EventDetailsDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import Foundation

struct EventInformationDataModal : Codable{
    var searchText : String = ""
    var eventName : String = ""
    var eventDate : String = ""
    var sportsName : String = ""
    var eventTime : String = ""
    var selectedStadium: String? = nil
    var stadium = ""
    var showStadiumDetails : Bool = false
    
}
