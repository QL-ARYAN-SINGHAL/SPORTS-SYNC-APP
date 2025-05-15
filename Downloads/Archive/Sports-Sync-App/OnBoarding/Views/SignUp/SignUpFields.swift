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
                FormTextfields(
                    textField: Binding(
                        get: {
                            guard
                                let email = formViewModal.signUpData.signUpEmail
                            else {
                                return ""
                            }
                            return email
                        },
                        set: { newValue in
                            formViewModal.signUpData.signUpEmail = newValue
                        }
                    ), placeholder: .emailPlaceholder)
            }

            // MARK: - First Name Field
            FormTextfields(
                textField: Binding(
                    get: {
                        guard let firstName = formViewModal.signUpData.firstName
                        else {
                            return ""
                        }
                        return firstName
                    },
                    set: { newValue in
                        formViewModal.signUpData.firstName = newValue
                    }
                ), placeholder: .firstNamePlaceholder
            )
            .onChange(of: formViewModal.signUpData.firstName ?? "") {
                newValue in
                if newValue.count > 10 {
                    formViewModal.signUpData.firstName =
                        formViewModal.characterLimit(newValue, limit: 10)
                }
            }

            // MARK: - Last Name Field
            FormTextfields(
                textField: Binding(
                    get: {
                        guard let lastName = formViewModal.signUpData.lastName
                        else { return "" }
                        return lastName
                    },
                    set: { newValue in
                        formViewModal.signUpData.lastName = newValue
                    }
                ), placeholder: .lastNamePlaceholder
            )
            .onChange(of: formViewModal.signUpData.lastName ?? "") {
                newValue in
                if newValue.count > 10 {
                    formViewModal.signUpData.lastName =
                        formViewModal.characterLimit(newValue, limit: 10)
                }
            }

            // MARK: - Password Field (Secure)
            ReusableSecureField(
                text: Binding(
                    get: {
                        guard
                            let password = formViewModal.signUpData
                                .signUpPassword
                        else {
                            return ""
                        }
                        return password
                    },
                    set: { newValue in
                        formViewModal.signUpData.signUpPassword = newValue
                    }
                ), placeholder: .passwordPlaceholder
            )
            .onChange(of: formViewModal.signUpData.signUpPassword ?? "") {
                newValue in
                if newValue.count > 17 {
                    formViewModal.signUpData.signUpPassword =
                        formViewModal.characterLimit(newValue, limit: 17)
                }
            }

            // MARK: - Confirm Password Field (Secure)
            ReusableSecureField(
                text: Binding(
                    get: {
                        guard
                            let confirmPassword =
                                formViewModal.signUpData.confirmPassword
                        else {
                            return ""
                        }
                        return confirmPassword
                    },
                    set: { newValue in
                        formViewModal.signUpData.confirmPassword = newValue
                    }
                ), placeholder: .confirmPasswordPlaceholder
            )
            .onChange(of: formViewModal.signUpData.signUpPassword ?? "") {
                newValue in
                if newValue.count > 17 {
                    formViewModal.signUpData.confirmPassword =
                        formViewModal.characterLimit(newValue, limit: 17)
                }
            }

        }
    }
}
