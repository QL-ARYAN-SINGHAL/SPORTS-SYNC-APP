import SwiftUI

struct MainTabView: View {
    @StateObject var tabRouter = TabRouter()
    @StateObject private var locationViewModel = LocationViewModel()
    let locationManager = LocationManager()

    @State private var currentLocation: String = "Fetching..."
    @State private var navigateNotification: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                TabView(selection: $tabRouter.tabDataModal.selectedTab) {
                    HomeView()
                        .tabItem {
                            ImageConstants.homeTabImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(verbatim: .homeTabName)
                        }
                        .tag(0)

                    EventView()
                        .environmentObject(tabRouter)
                        .tabItem {
                            ImageConstants.calenderTabImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(verbatim: .myEventTabName)
                        }
                        .tag(1)

                    FeedView()
                        .tabItem {
                            ImageConstants.verticalSliderTabImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(verbatim: .feedsTabName)
                        }
                        .tag(2)

                    UserProfileViewParent()
                        .tabItem {
                            ImageConstants.userTabImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(verbatim: .profileTabName)
                        }
                        .tag(3)
                }
                .accentColor(.appTint)
                .background(Color.white)
                .toolbar {
                    // Check if selectedTab is not 3 (User Profile tab)
                    if tabRouter.tabDataModal.selectedTab != 3 {
                        ToolbarItem(placement: .navigationBarLeading) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Current location")
                                    .foregroundColor(.gray)
                                    .font(.caption)

                                HStack {
                                    Image(systemName: "location.fill")
                                        .resizable()
                                        .frame(width: 16, height: 16)

                                    Text(locationViewModel.currentLocation)
                                        .font(
                                            Font.custom(
                                                .fontJakartaBold, size: 14)
                                        )
                                        .onTapGesture {
                                            locationViewModel.handleLocationTap()
                                        }
                                        .alert(
                                            isPresented: $locationViewModel
                                                .showLocationPermissionAlert
                                        ) {
                                            Alert(
                                                title: Text(
                                                    "Location Permission"),
                                                message: Text(
                                                    "Please enable location services in your device settings."
                                                ),
                                                primaryButton: .default(
                                                    Text("Go to Settings")
                                                ) {
                                                    if let url = URL(
                                                        string: UIApplication
                                                            .openSettingsURLString
                                                    ),
                                                        UIApplication.shared
                                                            .canOpenURL(url)
                                                    {
                                                        UIApplication.shared
                                                            .open(
                                                                url)
                                                    }
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                }
                            }

                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                navigateNotification = true
                            }) {
                                Image(systemName: "bell")
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .onAppear {
                    locationViewModel.requestLocationPermission()
                }
                .navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $navigateNotification) {
                    Notifications()
                }

            }
        }
       
    }
}

#Preview {
    MainTabView()
}
