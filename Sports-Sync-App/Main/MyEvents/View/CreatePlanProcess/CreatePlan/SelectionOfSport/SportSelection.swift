


//Responsibility : Here we are fetching the selected sports ards and data to be selected

import SwiftUI

struct SportSelection: View {
    
    @Environment(\.dismiss) private var dismiss
    private let imageConstants = ImageConstants()
    @StateObject var selectSportsViewModal = SelectSportsViewModal()
    
    @State private var selectedSport: SelectSportDataModal? = nil
    @State private var shouldNavigate = false
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
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
                
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                        ForEach(selectSportsViewModal.selectSportsData, id: \.self) { sport in
                            ReusableCreatePlanCards(
                                selectSportData: sport,
                                selectedSport: $selectedSport
                            )
                        }
                    }
                    .padding()
                }

                ActivatedButton(buttonText: .continueText, action: {
                    if selectedSport != nil {
                        shouldNavigate = true
                    }
                })
                .frame(height: 60, alignment: .center)
            }
            .onAppear {
                selectSportsViewModal.fetchSelectSports()
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $shouldNavigate) {
                EventInformationParent()
            }
        }
    }
}


#Preview {
    NavigationStack {
        SportSelection()
    }
}


