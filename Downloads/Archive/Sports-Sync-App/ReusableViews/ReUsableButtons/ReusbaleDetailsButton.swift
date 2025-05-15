import SwiftUI

struct ReusableDetailButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .font(Font.custom(.fontJakartaBold, size: 18))
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(Color.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReusableDetailButton(title: "Policy", action: {})
}
