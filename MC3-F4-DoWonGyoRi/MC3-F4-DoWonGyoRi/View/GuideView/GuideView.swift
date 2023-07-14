//
//  GuideView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI

struct GuideView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.theme.teBlack)
                            .frame(maxWidth: 17)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding(.horizontal, 36)
                .padding(.bottom, 30)
                VStack(spacing: 0) {
                    Text("테니스 가이드")
                        .font(.custom("Inter-Medium", size: 20))
                        .foregroundColor(Color.theme.teGreen)
                        .padding(.bottom, 6)
                    Rectangle()
                        .frame(width: 138, height: 3)
                        .foregroundColor(Color.theme.teGreen)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.horizontal, 30)
                
                ScrollView {
                    
                }
            }
        }
        
    }
    
}

struct GuideView_Preview: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
