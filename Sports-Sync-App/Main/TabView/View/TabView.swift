
//MARK: Responsibilty : Navigate among different sections of our application using tabbar
//To show curent location and notification we use toolbar

import SwiftUI

struct MainTabView: View {
    @StateObject var tabRouter = TabRouter()
    private var imageConstants = ImageConstants()
    let locationManager = LocationManager()
    
    @State private var currentLocation: String = "Fetching..."

    var body: some View {
        NavigationStack {
            TabView(selection: $tabRouter.tabDataModal.selectedTab) {
                HomeView()
                   
                    .tabItem {
                        imageConstants.homeTabImage
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .homeTabName)
                    }
                    
                    .tag(0)
                
                EventView()
                   
                    .tabItem {
                        imageConstants.calenderTabImage
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .myEventTabName)
                    }
                   
                    .tag(1)
                
                FeedView()
                    .tabItem {
                        imageConstants.verticalSliderTabImage
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .feedsTabName)
                    }
                    .tag(2)
                
                UserProfileViewParent()
                    .tabItem {
                        imageConstants.userTabImage
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(verbatim: .profileTabName)
                    }
                    .tag(3)
            }
            .accentColor(.appTint)
            .toolbar {
                if tabRouter.tabDataModal.selectedTab != 3 {
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
                                
                                Text(currentLocation)
                                    .font(Font.custom(.fontJakartaBold, size: 16))
                                    .lineLimit(1)
                            }
                        }
                        .frame(width: 375, height: 72, alignment: .leading)
                        .padding(.leading, 50)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Notification logic
                        }) {
                            imageConstants.notificationToolBarImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.white.withAlphaComponent(1)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
                
                
                locationManager.requestState { state in
                    currentLocation = state ?? "Unknown"
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    MainTabView()
}
