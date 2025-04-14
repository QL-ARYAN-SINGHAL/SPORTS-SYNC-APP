import SwiftUI

struct LandingScreen: View {
    
    //MARK: STATES
    @State private var offsetAnimation: CGFloat = UIScreen.main.bounds.width
    @State private var showSplash = true
    
    //MARK: INSTANCES OF FILES
    private var imageConstants = ImageConstants()
    
    var body: some View {
        VStack {
            // Splash Screen
            if showSplash {
                VStack {
                    Group {
                        imageConstants.appImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .offset(x: offsetAnimation)
                            .onAppear {
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                                    offsetAnimation = 0
                                }
                                
                                // Dispatch queue to set timer to toggle showSplash after 2 sec
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        showSplash = false
                                    }
                                }
                            }
                    }
                }
            } else {
                WelcomingScreen()
            }
        }
    }
}

#Preview {
    LandingScreen()
}
