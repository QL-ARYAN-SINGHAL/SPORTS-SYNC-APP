//
//  FeedViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
import SwiftUI
import PhotosUI

class FeedViewModal: ObservableObject {
    @Published var feedData = FeedDataModal()
    @Published var localImage: UIImage? = nil
    @Published var showPicker = false
    @Published var showingCamera = false

    @Published var selectedDeviceImage: PhotosPickerItem? = nil {
        didSet {
            setPostImage(from: selectedDeviceImage)
        }
    }

    private func setPostImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }

                DispatchQueue.main.async {
                    self.localImage = uiImage
                }
            } catch {
                print("Error loading image from picker:", error)
            }
        }
    }
}
