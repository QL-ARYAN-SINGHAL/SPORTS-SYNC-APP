import SwiftUI

struct UserProfileViewParent: View {
    @State private var navigationTermCondition: Bool = false
    @State private var navigationPrivacyPolicy: Bool = false
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                ProfileHeading()
                UserDetailsView()

                ReusableDetailButton(title: .privacyPolicyString, action: {
                    navigationPrivacyPolicy = true
                })

                ReusableDetailButton(title: .termsConditionString, action: {
                    navigationTermCondition = true
                })

                UserLogOut()

                    .navigationDestination(isPresented: $navigationPrivacyPolicy){
                        PrivacyPolicy()
                    }
                    .navigationDestination(isPresented: $navigationTermCondition){
                        TermsAndConditions()
                    }
            }
            .frame(height: 600, alignment: .top)
            
        }
    }
	
}

#Preview {
    UserProfileViewParent()
}
