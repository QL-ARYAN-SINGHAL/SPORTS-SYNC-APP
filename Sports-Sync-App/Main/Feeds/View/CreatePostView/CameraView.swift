//
//  CameraView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 07/05/25.


import SwiftUI
import Foundation
import UIKit

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var image: UIImage? // Holds the captured image
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the camera

    func makeUIViewController(context: Context) -> UIImagePickerController {
        // Create and return the camera interface
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Not needed for camera use
    }
    
    func makeCoordinator() -> Coordinator {
        // Creates coordinator to handle delegate methods
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent // Link back to parent view
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Called when an image is picked; assigns image and dismisses camera
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Called when user cancels; just dismisses the camera
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
