//
//  ProfileViewModel.swift
//  Sports-Sync-App
//
//  Created by 23187712V on 15/05/25.
//

import Foundation


class ProfileViewModel : ObservableObject, @unchecked Sendable {
    @Published var userData : SignUpDataModel?
    
    
    func getProfileDataFromCurrentSession() {
       
        DispatchQueue.main.async { [weak self] in
            self?.userData = UserSessionManager.getUserProfileDetails()
        }
    }
    

}
