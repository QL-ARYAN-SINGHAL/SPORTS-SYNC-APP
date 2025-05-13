import SwiftUI

struct EventButton: View {
    @State private var makeNavigation: Bool = false
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    makeNavigation = true
                }) {
                    Text(verbatim: .createPlanString)
                        .font(.custom(.fontJakartaBold, size: 12))
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.appTint)
                        )
                }
                
                // Using NavigationLink with isActive
                NavigationLink(
                    destination: SportSelection()
                        .environmentObject(tabRouter),
                    isActive: $makeNavigation,
                    label: { EmptyView() }
                )
            }
        }
    }
}

#Preview {
    EventButton()
        .environmentObject(TabRouter())
}
