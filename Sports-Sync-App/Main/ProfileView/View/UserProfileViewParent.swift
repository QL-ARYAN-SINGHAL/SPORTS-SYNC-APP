import SwiftUI

struct UserProfileViewParent: View {
    @State private var navigationDestination: String = ""
    @StateObject var firebaseValidation = FirebaseValidation()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                ProfileHeading()
                UserDetailsView()

                ReusableDetailButton(title: .privacyPolicyString, action: {
                    navigationDestination = "PrivacyPolicy"
                })

                ReusableDetailButton(title: .termsConditionString, action: {
                    navigationDestination = "TermsAndConditions"
                })

                UserLogOut()

                // Hidden NavigationLink Trigger
                NavigationLink(destination: destinationView(for: navigationDestination), isActive: .constant(!navigationDestination.isEmpty)) {
                    EmptyView()
                }
            }
            .frame(height: 600, alignment: .top)
            .environmentObject(firebaseValidation)
        }
    }

    @ViewBuilder
    private func destinationView(for destination: String) -> some View {
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

#Preview {
    UserProfileViewParent()
}
