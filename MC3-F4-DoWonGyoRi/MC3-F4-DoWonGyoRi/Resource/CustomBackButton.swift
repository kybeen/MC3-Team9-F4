//
//  CustomBackButton.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.blue)
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
    }
}
