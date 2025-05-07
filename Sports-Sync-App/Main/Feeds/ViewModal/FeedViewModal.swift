//
//  FeedViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI
import PhotosUI

class FeedViewModal : ObservableObject{
    @Published var feedData = FeedDataModal()
 
    @Published var localImage: UIImage? = nil
    @Published var showPicker = false
    @Published var selectedDeviceImage : PhotosPickerItem? = nil //this i t select the binding of photopicker item so that only photos are selcted 
}
