import SwiftUI

struct SignUpFields: View {
    @State var signUpemail: String = ""
    @State var signUppassword: String = ""
    @State var confirmPassword: String = ""
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var signUpPassword : String = ""
    
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            //MARK: SIGNUP TEXTFIELDS
            FormTextfields(textField: $signUpemail, placeholder: .emailPlaceholder)
            
            
            FormTextfields(textField: $firstName, placeholder: .firstNamePlaceholder)
            
            FormTextfields(textField: $lastName, placeholder: .lastNamePlaceholder)
            
            ReusableSecureField(text: $signUpPassword, placeholder: .passwordPlaceholder)
            
            ReusableSecureField(text: $confirmPassword, placeholder: .confirmPasswordPlaceholder)

        }
    }
}

#Preview {
    SignUpFields()
}
