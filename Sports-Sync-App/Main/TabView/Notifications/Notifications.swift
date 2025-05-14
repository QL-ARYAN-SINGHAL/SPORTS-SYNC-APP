//
//  Notifications.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/05/25.
//

import SwiftUI


struct Notifications: View {
    
    var body: some View {
        VStack {
//            Button(action : NotificationManager.notificationInstance.scheduleNotification ){
//                Text("Schedule my notification")
//                    
//            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                        //back button
                    }) {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Notifications")
                        .font(Font.custom(.fontJakartaBold, size: 18))
                        .foregroundStyle(.black)
                }
            
          
        }
    }
}
#Preview {
    NavigationView {
        Notifications()
    }
}

