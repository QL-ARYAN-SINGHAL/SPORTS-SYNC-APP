// SignUpAge.swift
// Sports-Sync-App
// Created by ARYAN SINGHAL on 13/04/25.

import SwiftUI

struct SignUpAge: View {
    @EnvironmentObject var formViewModal: FormViewModal

    private var ageRange: ClosedRange<Double> { 0...70 }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ageLabel
            ageSlider
        }
        .padding(.leading, -60)
    }

    // MARK: - Components

    private var ageLabel: some View {
        Text(formViewModal.signUpData.ageLabel ?? "Age: Not available")
            .font(Font.custom(.fontJakarta, size: 14))
            .padding(.leading, 5)
    }

    private var ageSlider: some View {
        Slider(
            value: Binding(
                get: {
                    guard let age = formViewModal.signUpData.ageValue else {
                        return 0
                    }
                    return age
                },
                set: { newValue in
                    formViewModal.signUpData.ageValue = newValue
                }
            ),
            in: ageRange,
            step: 1
        )
        .tint(.appTint)
        .frame(width: 300)
    }
}

#Preview {
    SignUpAge()
}
