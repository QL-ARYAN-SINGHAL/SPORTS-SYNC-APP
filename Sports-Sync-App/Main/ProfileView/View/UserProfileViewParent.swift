import SwiftUI

struct UserProfileViewParent: View {
    @State private var navigationDestination: String?
    @StateObject var firebaseValidation = FirebaseValidation()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                ProfileHeading()
                
                //User Details View
                UserDetailsView()
                
               
                ReusableDetailButton(title: .privacyPolicyString, action: {
                    navigationDestination = "PrivacyPolicy"
                })
                
                
                ReusableDetailButton(title: .termsConditionString, action: {
                    navigationDestination = "TermsAndConditions"
                })
                
                UserLogOut()
            }
            
            .frame(height: 600, alignment: .top)
            .navigationDestination(for: String.self) { destination in
                
                switch destination {
                    
                case "PrivacyPolicy":
                    
                    PrivacyPolicy()
                    
                case "TermsAndConditions":
                    
                    TermsAndConditions()
                    
                default:
                    
                    EmptyView()
                }
            }
            .environmentObject(firebaseValidation)
        }
    }
}

#Preview {
    UserProfileViewParent()
}
