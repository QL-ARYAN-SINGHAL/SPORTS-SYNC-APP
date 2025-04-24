//
//  HomeSportsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

//
//  HomeSportsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct HomeSportsListView: View {
    let sportsName = ["Cricket", "Badminton", "Football", "Tennis", "Volleyball", "Hockey", "Basketball"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                
                Button(action: {}) {
                    Text("All")
                        .font(.custom(.fontJakarta, size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.appTint))
                        .cornerRadius(10)
                }

                ForEach(sportsName, id: \.self) { sport in
                    ReusableListButtons(buttonText: sport, action: {})
                        .frame(width: 100, height: 40)
                }
               
            }
            .padding(.leading,10)
        }
    }
}

#Preview {
    HomeSportsListView()
}



