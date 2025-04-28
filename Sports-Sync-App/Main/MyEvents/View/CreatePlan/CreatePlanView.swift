import SwiftUI

struct CreatePlanView: View {
    @Environment(\.dismiss) private var dismiss
    private let imageConstants = ImageConstants()
    
    private let sportsNames = [
        "Team Sports",
        "Individual Sports",
        "Combat Sports",
        "Endurance Sports",
        "Racquet Sports",
        "Water Sports",
        "Winter Sports",
        "Adventure Sports",
        "Motor Sports",
        "Gymnastic"
    ]
   
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
       
            VStack(alignment: .leading, spacing: 16) {
                
                
                HStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        imageConstants.navigationBackImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 24)
                    }
                    
                    Text(verbatim: .selectSportString)
                        .font(Font.custom(.fontJakarta, size: 20))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                    ForEach(sportsNames, id: \.self) { sport in
                        ReusableCreatePlanCards(
                            imageName: imageConstants.sportImageNames[sport] ?? "DefaultSport",
                            cardText: sport
                        )
                    }
                }
                .padding()
            }
            ActivatedButton(buttonText: .continueText, action: {
                //navigate to next page
            })
            .navigationBarBackButtonHidden()
    }
        
}

#Preview {
    NavigationStack {
        CreatePlanView()
    }
}
