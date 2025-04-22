import SwiftUI

struct LogInFields: View {
    @EnvironmentObject var formViewModal: FormViewModal
    
    var body: some View {
        VStack(spacing: 17) {
            
            switch formViewModal.logInData.loginWith{
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
            
            
            ReusableSecureField(
                text: $formViewModal.logInData.loginPassword,
                placeholder: .passwordPlaceholder
            )
        }
        .padding()
    }
}

#Preview {
    LogInFields()
}
