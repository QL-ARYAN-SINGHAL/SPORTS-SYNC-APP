//
//  EventDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import Foundation

struct EventDataModal:Codable {
     
    var isViewHidden : Bool = false
    var userEventDate : String = ""
    var userEventName : String = ""
    var userEventTime : String = ""
    var userSportsName : String = ""
    var userSelectedStadium : String  = ""
}
