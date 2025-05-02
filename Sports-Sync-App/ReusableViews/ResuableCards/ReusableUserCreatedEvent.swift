import SwiftUI

struct ReusableUserCreatedEvent: View {
    
    var eventInfoDataModal: EventInformationDataModal
    var stadiumData: HomeCardsDataModal?

    var body: some View {
        HStack(spacing: 16) {
           
            AsyncImage(url: URL(string: stadiumData?.imageName ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 88, height: 87)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 88, height: 87)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 88, height: 87)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                @unknown default:
                    EmptyView()
                }
            }

            // Event details
            VStack(spacing: 1) {
                Text(eventInfoDataModal.selectedStadium ?? "Unknown Stadium")
                    .font(Font.custom(.fontJakartaBold, size: 13))
                    .frame(width: 223, height: 26, alignment: .leading)

                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                        Text(stadiumData?.location ?? "Unknown Location")
                            .font(Font.custom(.fontJakarta, size: 12))
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.yellow)
                        Text(stadiumData?.rating ?? "N/A")
                            .font(Font.custom(.fontJakarta, size: 12))
                    }
                }
                .frame(width: 223, height: 24, alignment: .leading)

                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                    Text(eventInfoDataModal.eventDate)
                        .font(Font.custom(.fontJakarta, size: 12))
                }
                .frame(width: 223, height: 24, alignment: .leading)

                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                    Text(eventInfoDataModal.eventTime)
                        .font(Font.custom(.fontJakarta, size: 12))
                }
                .frame(width: 223, height: 24, alignment: .leading)
            }
            .frame(width: 223, height: 84)
        }
        .frame(width: 327, height: 95)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

#Preview {
    ReusableUserCreatedEvent(
        eventInfoDataModal: EventInformationDataModal(
            searchText: "", eventName: "IPL", eventDate: "5 October",
            sportsName: "Cricket", eventTime: "6pm", selectedStadium: "Wankhede",
            stadium: "", showStadiumDetail: true
        ),
        stadiumData: HomeCardsDataModal(
            imageName: "https://example.com/stadium.jpg",
            sportsName: "Cricket",
            location: "Mumbai / 10km",
            rating: "4.5",
            description: "Iconic stadium",
            stadiumName: "Wankhede",
            eventDate: "2025-05-05",
            eventTime: "18:00"
        )
    )
}
