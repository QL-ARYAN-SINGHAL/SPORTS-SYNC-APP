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
    //this i t select the binding of photopicker item so that only photos are selcted
    @Published var selectedDeviceImage : PhotosPickerItem? = nil{
        didSet{
            setPostImage(from: selectedDeviceImage )
        }
    }
    
    private func setPostImage(from selection : PhotosPickerItem?){
        guard let selection else {return}
        
        Task{
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.localImage = uiImage
                        return
                    }
                   
                }
            }
            
            do{
                let data =  try await selection.loadTransferable(type: Data.self)
                
                guard let data ,let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                localImage = uiImage
            }
            catch{
                print(error)
            }
        }
    }
}
