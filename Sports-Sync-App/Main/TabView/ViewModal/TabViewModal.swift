//
//  TabViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 01/05/25.
//

import Foundation
import SwiftUI

class TabRouter: ObservableObject {
    @Published var tabDataModal = TabDataModal()
    @Published var shouldReturnToRoot = false
    
}

