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
            ZStack(alignment: .topLeading) {
                Image("StadiumImage")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 226)
                    .ignoresSafeArea(edges: .horizontal)
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
                        Text("Talktorea Indore Stadium")
                            .font(Font.custom(.fontJakartaBold, size: 16))
                        
                        HStack(spacing: 6) {
                            Image(systemName: "location.circle")
                            Text("Delhi")
                        }
                        .foregroundStyle(.disabledFont)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("4.5")
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

                ReusableSportDescription(eventHeading: "Event Date", eventInfo: "5 October 2025")
                ReusableSportDescription(eventHeading: "Event Time", eventInfo: "02:30 PM - 7:30 PM")
            }
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .top)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PlanDescriptionView(cardViewModel: CardViewModel())
}
