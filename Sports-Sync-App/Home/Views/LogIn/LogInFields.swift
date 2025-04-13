import SwiftUI

struct LogInFields: View {
    
    @State private var logInText: String = ""
    @State private var signUpText: String = ""
    
    var body: some View {
        VStack(spacing: 17) {
            FormTextfields(textField: $logInText, placeholder: .emailPlaceholder)
            
            ReusableSecureField(text: $signUpText, placeholder: .passwordPlaceholder)
        }
        .padding()
    }
}

#Preview {
    LogInFields()
}
