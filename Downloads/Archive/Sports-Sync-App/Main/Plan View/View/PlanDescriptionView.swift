import SwiftUI

struct PlanDescriptionView: View {

    // MARK: - Environment and Observed Variables
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cardViewModel: CardViewModel
    var userEvent: EventInformationDataModal? = nil
    var stadiumData: HomeCardsDataModal?
    @State private var isSharePresented = false
    @State private var generatedShareText: String = ""

    
    var body: some View {
        VStack(spacing: 25) {

            // MARK: - Event Display Logic (User-Created or Selected Card)
            
            if let userEvent = userEvent {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: stadiumData?.imageName ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ZStack {
                            Color.gray.opacity(0.3)
                            ProgressView()
                        }
                    }
                    .frame(height: 226)
                    .frame(maxWidth: .infinity)
                    .clipped()

                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss()
                            }) {
                                ImageConstants.navigationBackImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }

                }

                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 7) {
                        HStack {
                            Text(userEvent.selectedStadium ?? "")
                                .font(Font.custom(.fontJakartaBold, size: 18))

                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)

                                Text(stadiumData?.rating ?? "0.0")
                                    .font(.subheadline)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }

                        HStack(spacing: 6) {
                            Image(systemName: "location.circle")
                            Text(stadiumData?.location ?? "")
                        }
                        .foregroundColor(.secondary)
                    }

                    // Date, Time, Sport
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Date")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .foregroundColor(.primary)
                        Text(userEvent.eventDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Time")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .foregroundColor(.primary)
                        Text(userEvent.eventTime)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Sport")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .foregroundColor(.primary)
                        Text(userEvent.sportsName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }

            else if let selectedCard = cardViewModel.selectedCard {
                
                
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
                            ProgressView()
                        }
                    }
                    .frame(height: 226)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    
                    // MARK: - Back Button
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss()
                            }) {
                                ImageConstants.navigationBackImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }

                }

                // MARK: - Selected Card Information (Event Details)
                VStack(alignment: .leading, spacing: 25) {
                    
                   
                    VStack(alignment: .leading, spacing: 7) {
                        HStack{
                            Text(selectedCard.stadiumName)
                                .font(Font.custom(.fontJakartaBold, size: 16))
                            
                            HStack{
                                HStack {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 15)

                                    Text(cardViewModel.selectedCard?.rating ?? "0.0")
                                        .font(.subheadline)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                            
                        }
                        HStack(spacing: 6) {
                            Image(systemName: "location.circle")
                            Text(selectedCard.location)
                        }
                        .foregroundColor(.secondary)
                    }

                  
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Event Date")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .foregroundColor(.primary)
                        Text(selectedCard.eventDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Event Time")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .foregroundColor(.primary)
                        Text(selectedCard.eventTime)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 340 , alignment: .leading)
                
            } else {
                
                Text("No event selected.")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
        
        .navigationBarBackButtonHidden()
        
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .top)

        // MARK: - Footer Buttons (Share and Edit)
        HStack(spacing: 20) {
            ReusableShareFuncButton(text: .sharePlanString, action: {
                generatedShareText = cardViewModel.generateShareText(userEvent: userEvent, stadiumData: stadiumData)
                
                if generatedShareText.contains("Date: ") == false {
                    print("DEBUG: Event date missing in share text!")
                } else {
                    print("DEBUG: Share text is ready")
                }
                
                isSharePresented = true
            })
            
            ReusableEditFuncButtons(text: .editPlanString, action: {})
        }
        .sheet(isPresented: $isSharePresented) {
            ShareSheet(activityItems: [generatedShareText])
                .presentationDetents([.medium, .fraction(0.7), .large])
        }

        .frame(width: 375, height: 65)
    }
}
#Preview{
    PlanDescriptionView()
        .environmentObject(CardViewModel())
}
