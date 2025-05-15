import SwiftUI

struct LogInView: View {
    @Binding var isLoading: Bool
    @StateObject var formViewModal = FormViewModal()
    

    var body: some View {
        VStack {
            LogInFields()
                .padding()

            LogInButton(isLoading: $isLoading)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(formViewModal)
       
    }
}



// MARK: - Preview
#Preview {
    LogInView(isLoading: .constant(true))
}
