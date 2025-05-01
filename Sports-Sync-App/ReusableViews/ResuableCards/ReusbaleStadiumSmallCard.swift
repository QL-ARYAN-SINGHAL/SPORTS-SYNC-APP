//
//  ReusbaleStadiumSmallCard.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 01/05/25.
//

import SwiftUI

struct ReusableStadiumSmallCard: View {
    
    var stadiumcardData: HomeCardsDataModal
    
    
    var body: some View {
        
            HStack(spacing: 16) {
                
                VStack{
                    
                    //asynch image fetching from db with failure case covered
                    
                    AsyncImage(url: URL(string: stadiumcardData.imageName)) {
                        
                        phase in
                        
                        switch phase {
                            
                        case .empty:
                            ProgressView()
                                .frame(width: 88 , height : 87)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 88 , height : 87)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 88 , height : 87)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                //Vstack representing text details
                
                VStack{
                    
                    VStack {
                        
                        Text(stadiumcardData.stadiumName)
                        
                            .font(Font.custom(.fontJakartaBold, size: 13))
                            .frame(width: 223,height:26, alignment: .leading)
                    }
                    HStack{
                        
                        
                        HStack(spacing: 4) {
                            
                            Image(systemName: "location.fill")
                            
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                            
                            Text(stadiumcardData.location)
                            
                                .font(Font.custom(.fontJakarta, size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        HStack{
                            
                            Image(systemName: "star.fill")
                            
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.yellow)
                            
                            Text(stadiumcardData.rating)
                            
                                .font(Font.custom(.fontJakarta, size: 12))
                        }
                        
                        
                    }
                    .frame(width: 223, height: 24, alignment: .leading)
                }
                .frame(width: 223,height : 84)
                
            }
            .frame(width: 327,height : 87)
            
            .padding(5)
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
    }

#Preview {
    ReusableStadiumSmallCard(stadiumcardData: HomeCardsDataModal(
        imageName: "https://cdn.pixabay.com/photo/2023/08/12/08/46/ai-generated-8185136_960_720.png",
        sportsName: "Formula 1 Racing",
        location: "Delhi / 15km",
        rating: "4.5",
        description: "Sample Description",
        stadiumName: "Jakartala noida",
        eventDate : "2023-08-12",
        eventTime: "02:30 pm - 04:30 pm"
    ))
}
