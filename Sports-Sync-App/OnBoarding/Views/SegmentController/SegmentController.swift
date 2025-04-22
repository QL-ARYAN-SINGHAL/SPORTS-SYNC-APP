//
//  SegmentController.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SegmentController: View {
    @State private var currentView: Int = 0
    
   
    
    let options = ["LogIn", "SignUp"]

    var body: some View {
        VStack {
            //MARK: CUSTOMISE YOUR SEGMENT CONTROLLER WITH SCROLLVIEW ADDING 2 BUTTON AND NAVIGATE TO LOGIN AND SIGNUP ON TAP
            
            ScrollView(.horizontal, showsIndicators: false) {
                ZStack{
                    
                    //MARK: Round Rectangle that switches between the viewcontrolelrs
                    
                    RoundedRectangle(cornerRadius: 10).fill(Color.appTint)
                        .frame(width:90,height: 45,alignment: .leading)
                        .padding(.leading,-90)
                        .offset(x: CGFloat(currentView) * 90)
                    
                    //MARK: HStack having two options to switch to
                
                    HStack(spacing:0){
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index])
                                .bold()
                                .frame(width: 90, height: 45)
                               
                                .foregroundColor(currentView == index ? Color.white : Color.appTint)
                                .cornerRadius(10)
                            
                            //onTap gesture for animation and to be on a currentview
                                .onTapGesture {
                                        currentView = index
                                }
                            
                        }}
                   
                        
                    
                }
               
                .frame(width: 210, height: 65, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .padding(.horizontal, 100)
               
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width > 45 {
                                if currentView < options.count - 1 {
                                    withAnimation{
                                        currentView += 1
                                    }
                                }
                            } else if value.translation.width < 45 {
                                if currentView > 0 {
                                    withAnimation{
                                        currentView -= 1
                                    }
                                }
                            }
                        }
                )
            }

           
            if currentView == 0 {
                LogInView()
            } else {
                SignUpView()
            }
            
           
        }
        .navigationBarBackButtonHidden()
        Spacer()
    }
}

#Preview {
    SegmentController()
}
