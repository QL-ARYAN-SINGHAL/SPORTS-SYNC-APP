import SwiftUI

struct LandingScreen: View {
    
    //MARK: STATES
    @State private var offsetAnimation: CGFloat = UIScreen.main.bounds.width
    @State private var showSplash = true
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    
    //MARK: INSTANCES OF FILES
    private var imageConstants = ImageConstants()
    
    var body: some View {
        VStack {
            // Splash Screen
            if showSplash {
                VStack {
                    Group {
                        Text(verbatim: .appName)
                            .fontWeight(.bold)
                            
                            .font(Font.custom(.fontJakartaBold, size: 28))
                            .foregroundStyle(.appTint)
                           
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
            
//            //MARK: THIS IS TO MAINTAIN USER SESSION WHEN HE LOGS IN SO THAT ON REOPENING HE DOES NOT HAVE TO AGAIN LOGIN
//            if firebaseValidation.userSession != nil{
//                //USER WILL BE ON PROFILE PAGE
//            }else{
//                //USER AGAIN HAE TO LOGIN AND FILL IN DETAILSZ
//                SegmentController()
//            }
        }
    }
}

#Preview {
    LandingScreen()
}
