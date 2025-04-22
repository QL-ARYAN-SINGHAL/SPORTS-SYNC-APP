//
//  LogIn.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

//MARK: PARENT VIEW THAT HAS STATEOBJECT OF VIEW MODAL TO ACCESS BUILDER LOGIC AND DATA MODAL

struct LogInView: View {
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    var body: some View {
        VStack{
            LogInFields()
                .padding()
            LogInButton()
               
        }
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
//MARK: ENVIRONMENT OBJECT TO KEEP TRACK OF CHANGE OF DATA PRESENT INSIDE OUR DATA MODAL
       
    }
      
}

#Preview {
    LogInView()
}
