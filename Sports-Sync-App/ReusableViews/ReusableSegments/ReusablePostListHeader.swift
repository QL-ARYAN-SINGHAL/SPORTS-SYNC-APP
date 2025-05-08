import SwiftUI

struct ReusablePostListHeader: View {
    @EnvironmentObject var firebaseValidation: FirebaseValidation
    var userName: String
    var postTime: Date
    var userImage : UIImage?
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            
            Image(
                uiImage: userImage
                    ?? UIImage(
                        systemName: "person.crop.circle")!
            )
            .resizable()
            .scaledToFill()
            .frame(width: 41, height: 41)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(
                    Color.gray.opacity(0.3), lineWidth: 1)
            )
            .shadow(radius: 4)
            
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(userName)
                    .font(Font.custom(.fontJakartaBold, size: 14))
                    .frame(height: 18)

                HStack(spacing: 4) {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.disabledFont)

                    Text(postTime.formatted(date: .abbreviated, time: .omitted))
                        .font(Font.custom(.fontJakarta, size: 12))
                        .foregroundStyle(.disabledFont)
                }
            }

            Spacer()

            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .padding(6)
                .background(Circle().fill(Color.gray.opacity(0.2)))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .frame(height: 42)
    }
}

#Preview {
    ReusablePostListHeader(userName: "Hari Om", postTime: Date())
        .environmentObject(FirebaseValidation())
}
