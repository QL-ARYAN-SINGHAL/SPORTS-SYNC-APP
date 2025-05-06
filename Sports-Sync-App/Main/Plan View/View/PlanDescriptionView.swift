import SwiftUI

struct PlanDescriptionView: View {

    // MARK: - Environment and Observed Variables
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var cardViewModel: CardViewModel
    var userEvent: EventInformationDataModal? = nil  // Optional input for user-created event data
    var stadiumData: HomeCardsDataModal?
    
    var body: some View {
        VStack(spacing: 25) {

            // MARK: - Event Display Logic (User-Created or Selected Card)
            
            if let userEvent = userEvent {
                // Display user-created event with selectedCard image and location
                ZStack(alignment: .topLeading) {
                    
                    // MARK: - Image Display for Event (from selectedCard)
                    AsyncImage(url: URL(string: stadiumData?.imageName ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ZStack {
                            Color.gray.opacity(0.3)
                            ProgressView()  // Placeholder while the image loads
                        }
                    }
                    .frame(height: 226)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    
                    // MARK: - Back Button
                    Button {
                        dismiss()  // Dismiss the view when tapped
                    } label: {
                        ImageConstants.navigationBackImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(16)
                    }
                    .accessibilityLabel("Back")
                }

                // MARK: - Event Information (User Event Details)
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Event Stadium & Location
                    VStack(alignment: .leading, spacing: 7) {
                        Text(userEvent.selectedStadium ?? "")  // Stadium Name
                            .font(.title)
                            .bold()
                        HStack(spacing: 6) {
                            Image(systemName: "location.circle")
                            Text(cardViewModel.selectedCard?.location ?? "")  // Location (from selectedCard)
                        }
                        .foregroundColor(.secondary)  // Secondary color for less emphasis
                    }

                    // Event Info Sections (Date, Time, Sport)
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Date")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(userEvent.eventDate)  // Event Date
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Time")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(userEvent.eventTime)  // Event Time
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Sport")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(userEvent.sportsName)  // Sport Name
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)  // Padding for the whole section

            } else if let selectedCard = cardViewModel.selectedCard {
                // MARK: - Display Selected Card Event (When userEvent is nil)
                
                ZStack(alignment: .topLeading) {
                    
                    // MARK: - Image Display for Selected Card
                    AsyncImage(url: URL(string: selectedCard.imageName)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ZStack {
                            Color.gray.opacity(0.3)
                            ProgressView()  // Placeholder while the image loads
                        }
                    }
                    .frame(height: 226)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    
                    // MARK: - Back Button
                    Button {
                        dismiss()  // Dismiss the view when tapped
                    } label: {
                        ImageConstants.navigationBackImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(16)
                    }
                    .accessibilityLabel("Back")
                }

                // MARK: - Selected Card Information (Event Details)
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Stadium Info and Location
                    VStack(alignment: .leading, spacing: 7) {
                        Text(selectedCard.stadiumName)  // Stadium Name
                            .font(Font.custom(.fontJakartaBold, size: 16))
                        HStack(spacing: 6) {
                            Image(systemName: "location.circle")
                            Text(selectedCard.location)  // Location (from selectedCard)
                        }
                        .foregroundColor(.secondary)
                    }

                    // Rating Information
                    HStack {
                        Text(selectedCard.rating)  // Rating (from selectedCard)
                            .font(Font.custom(.fontJakartaBold, size: 16))
                            .foregroundColor(.black)

                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                    }
                    .frame(width: 59, height: 36)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(4)

                    // Event Date and Time Information
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Event Date")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(selectedCard.eventDate)  // Event Date
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Event Time")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(selectedCard.eventTime)  // Event Time
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 16)  // Padding for the whole section
            } else {
                // No event selected, show a fallback message
                Text("No event selected.")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
//        .onAppear {
//            cardViewModal.fetchAllCards()
//            Task {
//                await eventViewModal.getUserCreatedEvent()
//            }
//        }
        .navigationBarBackButtonHidden()  // Hides the default back button
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .top)  // Limit height to 90% of screen height

        // MARK: - Footer Buttons (Share and Edit)
        HStack(spacing: 20) {
            ReusableShareFuncButton(text: .sharePlanString, action: {})  // Share Button
            ReusableEditFuncButtons(text: .editPlanString, action: {})  // Edit Button
        }
        .frame(width: 375, height: 65)  // Footer button frame size
    }
}
