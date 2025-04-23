//
//  TabView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//MARK: Responsibility: This would help to travel accross screen as per the user request. It will have tabbar items that will be having 4 views to present

import SwiftUI

struct MainTabView: View {
    private var imageConstants = ImageConstants()
    
    var body: some View {
        // TabView is a normal stack-like View
        
        VStack{
            TabView {
                HomeView()
                    .tabItem {
                        imageConstants.homeTabImage.renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .homeTabName)
                    }
                
                EventView()
                    .tabItem {
                        imageConstants.calenderTabImage.renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .myEventTabName)
                    }
                
                UserFeedView()
                    .tabItem {
                        imageConstants.verticalSliderTabImage.renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .feedsTabName)
                    }
                
                ProfileView()
                    .tabItem {
                        imageConstants.userTabImage.renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .profileTabName)
                    }
            }
            .background(.black)
            .accentColor(.appTint)
            .navigationBarBackButtonHidden()

        }
        
    }
}

#Preview {
    MainTabView()
}

