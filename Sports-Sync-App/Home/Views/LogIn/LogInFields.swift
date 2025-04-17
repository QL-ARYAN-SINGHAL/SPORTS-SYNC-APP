import SwiftUI

struct LogInFields: View {
    @StateObject var logInValidation = LoginValidation()

    var body: some View {
        VStack(spacing: 17) {
           
            FormTextfields(textField: $logInValidation.logInData.loginEmail, placeholder: .emailPlaceholder)
          
            ReusableSecureField(text:$logInValidation.logInData.loginPassword, placeholder: .passwordPlaceholder)
        }
        .padding()
    }
}

#Preview {
    LogInFields()
}
