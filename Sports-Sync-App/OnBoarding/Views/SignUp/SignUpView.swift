import SwiftUI

struct SignUpView: View {
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    
    @Binding var isLoading: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    SignUpHeading()
                    SignUpFields()
                    SignUpAge()
                    SignUpGender()
                    SignUpButton(isLoading: $isLoading)
                    Divider()
                    SignUpProgressBar()
                }
                
                if isLoading {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    ProgressView("Signing up...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
        }
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
    }
}

#Preview {
    SignUpView(isLoading: .constant(true))
}
