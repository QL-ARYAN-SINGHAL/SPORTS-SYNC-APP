import SwiftUI

struct SportSelection: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject var selectSportsViewModal = SelectSportsViewModal()
    @EnvironmentObject var tabRouter: TabRouter
    @State private var selectedSport: SelectSportDataModal? = nil
    @State private var shouldNavigate = false
    @State private var showAlert: Bool = false

    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        
            VStack(alignment: .leading, spacing: 16) {

                HStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        ImageConstants.navigationBackImage
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
                        ForEach(
                            selectSportsViewModal.selectSportsData, id: \.self
                        ) { sport in
                            ReusableCreatePlanCards(
                                selectSportData: sport,
                                selectedSport: $selectedSport
                            )
                        }
                    }
                    .padding()
                }

                ActivatedButton(
                    buttonText: .continueText,
                    action: {
                        if selectedSport != nil {
                            shouldNavigate = true
                        } else {
                            showAlert = true
                        }
                    }
                )
                .frame(height: 60, alignment: .center)

                // Using NavigationLink with isActive to navigate
                NavigationLink(
                    destination: EventInformationParent()
                        .environmentObject(tabRouter),
                    isActive: $shouldNavigate
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .onAppear {
                selectSportsViewModal.fetchSelectSports()
            }
            .alert("Select Sport to create Event", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }

            .navigationBarBackButtonHidden()
        }
    }


#Preview {
    NavigationStack {
        SportSelection()
    }
}
