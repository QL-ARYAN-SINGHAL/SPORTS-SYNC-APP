//
//  ForgetPasswordView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPasswordView: View {

    @StateObject var formViewModal = FormViewModal()
   

    var body: some View {
        VStack {
            ForgetPasswordText()
                .padding()
            ForgetPaswordTextField()

            ForgetPasswordButton()
        }
        .environmentObject(formViewModal)
         Spacer()
        .navigationBarBackButtonHidden(false)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    ForgetPasswordView()
}
