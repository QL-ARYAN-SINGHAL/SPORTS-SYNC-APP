import PhotosUI
//
//  PhotoVideoPicker.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
import SwiftUI

struct PhotoVideoPickerFooter: View {
    @EnvironmentObject var feedViewModal: FeedViewModal
    @State private var navigateToCamera = false

    var body: some View {
        
            VStack {
                Divider()
                HStack {
                    // Camera button
                    ReusablePhotoVideoPicker(
                        iconName: "camera.fill", labelText: .cameraString
                    )
                    .onTapGesture {
                        navigateToCamera = true
                    }

                    // Gallery button
                    PhotosPicker(
                        selection: $feedViewModal.selectedDeviceImage,
                        matching: .any(of: [.images]),
                        photoLibrary: .shared()
                    ) {
                        ReusablePhotoVideoPicker(
                            iconName: "photo.fill.on.rectangle.fill",
                            labelText: .photoVideoString)
                    }
                }
                .frame(width: 343, height: 60, alignment: .leading)

              
                    
                    NavigationLink(
                        destination: CameraView(
                            image: $feedViewModal.feedData.localImage),
                        isActive: $navigateToCamera
                    ) {
                        EmptyView()
                    }
                    .hidden()
                
            }
            // Debug log
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
