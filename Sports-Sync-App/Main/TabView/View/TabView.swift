import SwiftUI

struct MainTabView: View {
    private var imageConstants = ImageConstants()
    
    var body: some View {
        VStack {
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
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    MainTabView()
}
