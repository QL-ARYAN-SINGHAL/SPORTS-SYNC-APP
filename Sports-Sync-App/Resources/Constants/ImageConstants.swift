//
//  ImageConstants.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import Foundation
import SwiftUI

struct ImageConstants{
    
    var appImage = Image("SportSync")
    var welcomeBikeImage = Image("welcomeBikeImage")
    var successImage = Image("Success")
    var navigationBackImage = Image("NavigationBackImage")
    var homeTabImage = Image("home")
    var userTabImage = Image("user-2")
    var calenderTabImage = Image("calendar")
    var verticalSliderTabImage = Image("slider-vertical")
    var notificationToolBarImage = Image("Notification")
    var locationToolBarImage = Image("location")
    var emptyBoxImage = Image("emptyBox")
    var calendarMonthImage = Image("calendarMonth")
    let sportImageNames: [String: String] = [
           "Team Sports": "baseball",
           "Individual Sports": "IndivisualSports",
           "Combat Sports": "Boxing",
           "Endurance Sports": "EnduranceSports",
           "Racquet Sports": "RacquetSports",
           "Water Sports": "WaterSports",
           "Winter Sports": "WinterSports",
           "Adventure Sports": "AdventureSports",
           "Motor Sports": "MotorSports",
           "Gymnastic": "Gymnastic"
       ]
}
