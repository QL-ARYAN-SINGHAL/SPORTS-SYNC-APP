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
                
             
            }
        }
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
          }
    }


#Preview {
    SignUpView(isLoading: .constant(true))
}
