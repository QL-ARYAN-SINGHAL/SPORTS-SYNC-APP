//
//  PlanDescriptionView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//


import SwiftUI

struct PlanDescriptionView: View {

    @Environment(\.dismiss) private var dismiss
    private let imageConstants = ImageConstants()
    @ObservedObject var cardViewModel: CardViewModel

    var body: some View {
        VStack(spacing: 25) {
            if let selectedCard = cardViewModel.selectedCard {
                ZStack(alignment: .topLeading) {
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
                    
                    
                    Button(action: { dismiss() }) {
                        imageConstants.navigationBackImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                    }
                }
                
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        VStack(alignment: .leading, spacing: 7) {
                            Text(selectedCard.stadiumName)
                                .font(Font.custom(.fontJakartaBold, size: 16))
                            
                            HStack(spacing: 6) {
                                Image(systemName: "location.circle")
                                Text(selectedCard.location)
                            }
                            .foregroundStyle(.disabledFont)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text(selectedCard.rating)
                                .font(Font.custom(.fontJakartaBold, size: 16))
                                .foregroundStyle(.black)
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                        }
                        .frame(width: 59, height: 36)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                    }
                    
                    ReusableSportDescription(eventHeading: "Event Date", eventInfo: selectedCard.eventDate)
                    ReusableSportDescription(eventHeading: "Event Time", eventInfo: selectedCard.eventTime)
                }
                .padding(.horizontal, 16)
            } else {
                Text("No event selected.")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .top)
        .navigationBarBackButtonHidden()
        
        HStack(spacing: 20){
            ReusableShareFuncButton(text: .sharePlanString, action: {})
            
            
            ReusableEditFuncButtons(text: .editPlanString, action: {})
            
        }
        .frame(width: 375,height: 65)
        
    }
}

#Preview {
    let mockVM = CardViewModel()
    mockVM.selectedCard = HomeCardsDataModal(
        imageName: "https://cdn.pixabay.com/photo/2023/08/12/08/46/ai-generated-8185136_960_720.png",
        sportsName: "FormulaF1Racing",
        location: "Delhi",
        rating: "4.5",
        description: "Formula 1 racing!",
        stadiumName: "Talktorea Indore Stadium",
        eventDate: "5 October 2025",
        eventTime: "02:30 PM - 7:30 PM"
    )
    return PlanDescriptionView(cardViewModel: mockVM)
}
