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
      
            }
            
            // MARK: - First Name Field
            FormTextfields(textField: $formViewModal.signUpData.firstName, placeholder: .firstNamePlaceholder)
                .onChange(of: formViewModal.signUpData.firstName) { newValue in
                    if newValue.count > 10 {
                        formViewModal.signUpData.firstName = formViewModal.characterLimit(newValue, limit: 10)
                    }
                }

            
            // MARK: - Last Name Field
            FormTextfields(textField: $formViewModal.signUpData.lastName, placeholder: .lastNamePlaceholder)
                .onChange(of: formViewModal.signUpData.lastName) { newValue in
                    if newValue.count > 10 {
                        formViewModal.signUpData.lastName = formViewModal.characterLimit(newValue, limit: 10)
                    }
                }
            
            // MARK: - Password Field (Secure)
            ReusableSecureField(text: $formViewModal.signUpData.signUpPassword, placeholder: .passwordPlaceholder)
                .onChange(of: formViewModal.signUpData.signUpPassword) { newValue in
                    if newValue.count > 17 {
                        formViewModal.signUpData.signUpPassword = formViewModal.characterLimit(newValue, limit: 17)
                    }
                }
            
            // MARK: - Confirm Password Field (Secure)
            ReusableSecureField(text: $formViewModal.signUpData.confirmPassword, placeholder: .confirmPasswordPlaceholder)
                .onChange(of: formViewModal.signUpData.confirmPassword) { newValue in
                    if newValue.count > 17 {
                        formViewModal.signUpData.confirmPassword = formViewModal.characterLimit(newValue, limit: 17)
                    }
                }
        }
    }
}
