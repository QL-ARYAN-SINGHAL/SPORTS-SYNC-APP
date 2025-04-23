//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//

import SwiftUI

struct ToolBarView: View {
    private var imageConstants = ImageConstants()
    
    var body: some View {
        
        NavigationView {
            MainTabView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            VStack(spacing: 6) {
                                Text("Current location")
                                    .foregroundColor(.black.opacity(0.6))
                                    .font(Font.custom(.fontJakarta, size: 12))
                                HStack{
                                    imageConstants.locationToolBarImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    
                                    Text("Delhi")
                                        .font(Font.custom(.fontJakartaBold, size: 16))
                                }
                                .padding(.leading,-20)
                            }
                            
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button(action : {
                                
                            }, label : {
                                imageConstants.notificationToolBarImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24 , height: 24)
                            })
                        }
                        
                    }
        
                }
        }
    }

#Preview {
    ToolBarView()
}
