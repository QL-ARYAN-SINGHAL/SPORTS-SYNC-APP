//
//  SegmentController.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//
import SwiftUI

struct SegmentController: View {
    @State private var currentView: Int = 0
    @State private var isLoading: Bool = false  
    
    let options = ["LogIn", "SignUp"]

    var body: some View {
        VStack {
            // MARK: Segment Controller
            ScrollView(.horizontal, showsIndicators: false) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.appTint)
                        .frame(width: 90, height: 45)
                        .padding(.leading, -90)
                        .offset(x: CGFloat(currentView) * 90)

                    HStack(spacing: 0) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index])
                                .bold()
                                .frame(width: 90, height: 45)
                                .foregroundColor(currentView == index ? .white : .appTint)
                                .onTapGesture {
                                    withAnimation {
                                        currentView = index
                                    }
                                }
                        }
                    }
                }
                .frame(width: 210, height: 65)
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
                                    withAnimation {
                                        currentView += 1
                                    }
                                }
                            } else if value.translation.width < -45 {
                                if currentView > 0 {
                                    withAnimation {
                                        currentView -= 1
                                    }
                                }
                            }
                        }
                )
            }

            // MARK: View Switching
            if currentView == 0 {
                LogInView(isLoading: $isLoading)
            } else {
                SignUpView(isLoading: $isLoading)
            }
        }
        .navigationBarBackButtonHidden()
        Spacer()
    }
}

#Preview {
    SegmentController()
}
