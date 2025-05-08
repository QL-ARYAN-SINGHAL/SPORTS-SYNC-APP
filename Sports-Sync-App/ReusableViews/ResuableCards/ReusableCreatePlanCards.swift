//
//  ReusableCreatePlanCards.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 28/04/25.
//
import SwiftUI
    
struct ReusableCreatePlanCards: View {
    
    var selectSportData: SelectSportDataModal
    @Binding var selectedSport: SelectSportDataModal?
    
    var isSelected: Bool {
        selectedSport?.sportsName == selectSportData.sportsName
    }

    var body: some View {
        Button(action: {
            selectedSport = selectSportData
        }) {
            VStack {
                AsyncImage(url: URL(string: selectSportData.sportsImage)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 37, height: 47)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 37, height: 47)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 37, height: 47)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(selectSportData.sportsName)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .frame(width: 125, height: 24)
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 10)
            .frame(width: 159, height: 104)
        }
        .background(Color(.disabledButton).opacity(0.25))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.appTint : Color(.disabledButton), lineWidth: 1)
        )
    }
}


#Preview {
   @State var selectedSport: SelectSportDataModal? = nil
    return ReusableCreatePlanCards(
        selectSportData: SelectSportDataModal(sportsName: "Endurance", sportsImage: "endurance"),
        selectedSport: $selectedSport
    )
}

