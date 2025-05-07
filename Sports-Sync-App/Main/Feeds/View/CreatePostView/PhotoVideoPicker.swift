//
//  PhotoVideoPicker.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
import SwiftUI
import PhotosUI

struct PhotoVideoPickerFooter: View {
    @EnvironmentObject var feedViewModal: FeedViewModal

    var body: some View {
        Divider()
        HStack {
            // Open camera to select photo
            PhotoVideoPickerButton(iconName: "camera.fill", labelText: .cameraString)

            // Open gallery to select image or video
            PhotosPicker(
                selection: $feedViewModal.selectedDeviceImage,
                matching: .any(of: [.images, .videos]),
                photoLibrary: .shared()
            ) {
                PhotoVideoPickerButton(iconName: "photo.fill.on.rectangle.fill", labelText: .photoVideoString)
            }
        }
        .frame(width: 343, height: 60, alignment: .leading)
        
        //debug to check if image is gettting or not
        .onChange(of: feedViewModal.selectedDeviceImage) { newValue in
            if let newValue = newValue {
                print("Selected item: \(newValue)")
            } else {
                print("No image or video selected.")
            }
        }
    }
}


#Preview {
    PhotoVideoPickerFooter()
        .environmentObject(FeedViewModal())
}
