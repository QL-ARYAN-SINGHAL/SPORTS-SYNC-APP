
//MARK: Responsibilty : Navigate among different sections of our application using tabbar
//To show curent location and notification we use toolbar


import SwiftUI

struct MainTabView: View {
    private var imageConstants = ImageConstants()
    
    var body: some View {
        NavigationStack {
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
            .accentColor(.appTint)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack(spacing: 6) {
                        Text("Current location")
                            .foregroundColor(.black.opacity(0.6))
                            .font(Font.custom(.fontJakarta, size: 12))
                        HStack {
                            imageConstants.locationToolBarImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                            
                            Text("Delhi")
                                .font(Font.custom(.fontJakartaBold, size: 16))
                                
                        }
                        .padding(.leading, -20)
                    }
                    .frame(width: 375, height: 72,alignment:.leading)
                    .padding(.leading,50)
                  
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //Notification Page entry
                    }, label: {
                        imageConstants.notificationToolBarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    })
                }
            }
            
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    MainTabView()
}
