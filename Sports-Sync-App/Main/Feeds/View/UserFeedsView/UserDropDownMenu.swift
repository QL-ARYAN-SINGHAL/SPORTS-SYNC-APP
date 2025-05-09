import SwiftUI

struct UserDropdownMenu: View {
    @Binding var selectedOption: String

    var body: some View {
        Menu {
            Button("General") { selectedOption = "General" }
            Button("My Feed") { selectedOption = "My Feed" }
        } label: {
            HStack {
                Text(selectedOption)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.appTint)
            .clipShape(Capsule())
        }
        .frame(height : 30)
        .padding(.trailing, 20)
    }
}
