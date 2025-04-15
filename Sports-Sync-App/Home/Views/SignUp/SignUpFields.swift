import SwiftUI

struct SignUpFields: View {
    
    @EnvironmentObject var signUpData: SignUpDataModel
    @StateObject var progressValidation = ProgressValueCalculator()
    
    var body: some View {
        VStack(spacing: 15) {
            
            // MARK: SIGNUP TEXTFIELDS
            FormTextfields(textField: $signUpData.signUpEmail, placeholder: .emailPlaceholder)
                .onSubmit {
                    progressValidation.calculateProgress()
                }

            FormTextfields(textField: $signUpData.firstName, placeholder: .firstNamePlaceholder)
                .onSubmit {
                    progressValidation.calculateProgress()
                }

            FormTextfields(textField: $signUpData.lastName, placeholder: .lastNamePlaceholder)
                .onSubmit {
                    progressValidation.calculateProgress()
                }

            ReusableSecureField(text: $signUpData.signUpPassword, placeholder: .passwordPlaceholder)
                .onSubmit {
                    progressValidation.calculateProgress()
                }

            ReusableSecureField(text: $signUpData.confirmPassword, placeholder: .confirmPasswordPlaceholder)
                .onSubmit {
                    progressValidation.calculateProgress()
                }
        }
    }
}


#Preview {
    SignUpFields()
}
