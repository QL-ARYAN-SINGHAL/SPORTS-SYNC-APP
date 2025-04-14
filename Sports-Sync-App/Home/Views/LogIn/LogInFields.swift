import SwiftUI

struct LogInFields: View {
    
    @State private var logInData = LoginDataModal()

    var body: some View {
        VStack(spacing: 17) {
           
            FormTextfields(textField: $logInData.loginEmail, placeholder: .emailPlaceholder)

            ReusableSecureField(text: $logInData.loginPassword, placeholder: .passwordPlaceholder)
        }
        .padding()
    }
}

#Preview {
    LogInFields()
}
