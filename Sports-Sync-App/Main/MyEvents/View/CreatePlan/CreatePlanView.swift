//
//  CreatePlanView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 28/04/25.
//

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
     
            ScrollView {
                VStack{
                    HStack{
                       
                        Text(verbatim: .selectSportString)
                            .font(Font.custom(.fontJakarta, size: 18))
                            .frame(width: 320,height: 15,alignment: .leading)
                        
                        
                    }
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
            }
        
         .navigationBarCustombackButton(content:{
             Button(action : {dismiss() }, label: {
                 imageConstants.navigationBackImage
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50 , height: 30)
                     
             })
         })
         
         
        }
        
    }
    


#Preview {
    CreatePlanView()
}
