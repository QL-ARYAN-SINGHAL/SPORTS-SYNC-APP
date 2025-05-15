import SwiftUI

struct SignUpView: View {
    @StateObject var formViewModal = FormViewModal()
    
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
       
          }
    }


#Preview {
    SignUpView(isLoading: .constant(true))
}
