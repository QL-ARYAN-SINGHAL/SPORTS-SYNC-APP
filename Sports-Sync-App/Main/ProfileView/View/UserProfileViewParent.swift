import SwiftUI

struct UserProfileViewParent: View {
    @State private var navigationDestination: String?

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                //User Details View
                UserDetailsView()
                
               
                ReusableDetailButton(title: .privacyPolicyString, action: {
                    navigationDestination = "PrivacyPolicy"
                })
                
                
                ReusableDetailButton(title: .termsConditionString, action: {
                    navigationDestination = "TermsAndConditions"
                })
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
        }
    }
}

#Preview {
    UserProfileViewParent()
}
