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
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.theme.teGreen)
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
    }
}

struct shareButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationLink(destination: CameraView()) {
            Image("instagram_icon")
        }
    }
}
