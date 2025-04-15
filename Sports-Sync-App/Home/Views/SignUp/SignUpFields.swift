import SwiftUI

struct SignUpFields: View {
    
    @EnvironmentObject var signUpData: SignUpDataModel
    @StateObject var progressValidation = ProgressValueCalculator()
    
    var body: some View {
        VStack(spacing: 15) {
            
            FormTextfields(textField: $signUpData.signUpEmail, placeholder: .emailPlaceholder)
                
                

            FormTextfields(textField: $signUpData.firstName, placeholder: .firstNamePlaceholder)
                
                

            FormTextfields(textField: $signUpData.lastName, placeholder: .lastNamePlaceholder)
               

            ReusableSecureField(text: $signUpData.signUpPassword, placeholder: .passwordPlaceholder)
                

            ReusableSecureField(text: $signUpData.confirmPassword, placeholder: .confirmPasswordPlaceholder)
                
        }
    }
}
