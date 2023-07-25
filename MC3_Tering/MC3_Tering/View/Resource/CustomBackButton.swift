//
//  CustomBackButton.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.theme.teGreen)
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
    }
}
