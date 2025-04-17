import SwiftUI

struct SignUpFields: View {
    
    @EnvironmentObject var formViewModal: FormViewModal
   
    
    var body: some View {
        VStack(spacing: 15) {
            
            FormTextfields(textField: $formViewModal.signUpData.signUpEmail, placeholder: .emailPlaceholder)
                
                

            FormTextfields(textField: $formViewModal.signUpData.firstName, placeholder: .firstNamePlaceholder)
                
                

            FormTextfields(textField: $formViewModal.signUpData.lastName, placeholder: .lastNamePlaceholder)
               

            ReusableSecureField(text: $formViewModal.signUpData.signUpPassword, placeholder: .passwordPlaceholder)
                

            ReusableSecureField(text: $formViewModal.signUpData.confirmPassword, placeholder: .confirmPasswordPlaceholder)
                
        }
    }
}
