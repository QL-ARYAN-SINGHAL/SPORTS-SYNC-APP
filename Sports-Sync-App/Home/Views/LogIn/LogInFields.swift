import SwiftUI

struct LogInFields: View {
    
    //MARK: ENVIRONMENT OBJECT THAT CHECKS THE CHANGE IN OUR ENVIRONMENT THAT CONFORM TO OBSERVALEOBJECT
    
    @EnvironmentObject var formViewModal : FormViewModal
    
    var body: some View {
        VStack(spacing: 17) {
           
            FormTextfields(textField: $formViewModal.logInData.loginEmail, placeholder: .emailPlaceholder)
          
            ReusableSecureField(text:$formViewModal.logInData.loginPassword, placeholder: .passwordPlaceholder)
        }
        .padding()
    }
}

#Preview {
    LogInFields()
}
