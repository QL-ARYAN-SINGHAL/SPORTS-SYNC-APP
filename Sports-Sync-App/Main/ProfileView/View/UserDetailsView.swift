//
//  UserDetailsView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var firebaseValidation = FirebaseValidation()
   
    var body: some View {
        VStack{
            Button(action : {}){
                HStack(spacing : 20){
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 76 , height: 76)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    VStack{
                        Text(firebaseValidation.signUpData.firstName)
                            .font(Font.custom(.fontJakartaBold, size: 20))
                            .frame(width: 179,height:28,alignment: .leading)
                            .foregroundStyle(.black)
                        
                        Text(firebaseValidation.signUpData.signUpEmail)
                            .font(Font.custom(.fontJakarta, size: 14))
                            .foregroundStyle(.black)
                        
                        HStack(spacing :2){
                            
                            Text(/*formViewModal.signUpData.ageValue*/"21")
                                .font(Font.custom(.fontJakarta, size: 14))
                               
                                .foregroundStyle(.gray)
                            
                            Text(/*firebaseValidation.signUpData.selectedGender*/"Male")
                                .font(Font.custom(.fontJakarta, size: 14))
                              
                                .foregroundStyle(.gray)
                            
                        }
                        .frame(width: 179,height:28,alignment: .leading)
                    }
                    .frame(width: 219,height: 100,alignment: .leading)
                }
            }
            .frame(width: 343 , height: 144)
            .padding(.leading,16)
            .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.5))
        }
        .onAppear{
            firebaseValidation.getUserData()
            print( firebaseValidation.getUserData())
        }
    }
}

#Preview {
    UserDetailsView()
}
