import SwiftUI

struct LogInFields: View {
    
    // MARK: - Environment Object
    @EnvironmentObject var formViewModal: FormViewModal
    
    
    var body: some View {
        VStack(spacing: 17) {
            
            // MARK: - Dynamic Field Based on Login Method
            switch formViewModal.logInData.loginWith {
            case .withEmail:
                
                FormTextfields(
                    textField: $formViewModal.logInData.loginEmail,
                    placeholder: .emailPlaceholder
                )
                
            case .withPhoneNumber:
               
                FormTextfields(
                    textField: $formViewModal.logInData.phoneNumber,
                    placeholder: .emailPlaceholder
                )
            }
            
            // MARK: - Secure Password Field
            ReusableSecureField(
                text: $formViewModal.logInData.loginPassword,
                placeholder: .passwordPlaceholder
            )
        }
        .padding()
    }
}

#Preview {
    LogInView(isLoading: .constant(true))
}
