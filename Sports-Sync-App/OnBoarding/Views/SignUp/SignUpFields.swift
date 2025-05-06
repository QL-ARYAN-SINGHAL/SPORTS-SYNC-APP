import SwiftUI

struct SignUpFields: View {
    
    // MARK: - Environment Object
    @EnvironmentObject var formViewModal: FormViewModal
    
    var body: some View {
        VStack(spacing: 15) {  // MARK: - Vertical Stack for Form Fields
            
            // MARK: - Switch for SignUp Method (Email or Phone)
            switch formViewModal.signUpData.signUpWith {
                
            case .withEmail:
                // MARK: - Email Field
                FormTextfields(textField: $formViewModal.signUpData.signUpEmail, placeholder: .emailPlaceholder)
                
            case .withPhoneNumber:
                // MARK: - Phone Number Field
                FormTextfields(textField: $formViewModal.signUpData.phoneNumber, placeholder: .emailPlaceholder)
            }
            
            // MARK: - First Name Field
            FormTextfields(textField: $formViewModal.signUpData.firstName, placeholder: .firstNamePlaceholder)
            
            // MARK: - Last Name Field
            FormTextfields(textField: $formViewModal.signUpData.lastName, placeholder: .lastNamePlaceholder)
            
            // MARK: - Password Field (Secure)
            ReusableSecureField(text: $formViewModal.signUpData.signUpPassword, placeholder: .passwordPlaceholder)
            
            // MARK: - Confirm Password Field (Secure)
            ReusableSecureField(text: $formViewModal.signUpData.confirmPassword, placeholder: .confirmPasswordPlaceholder)
        }
    }
}
