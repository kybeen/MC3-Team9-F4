//
//  CongreteModalView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/16.
//

import SwiftUI

struct CongreteModalView: View {
    @State private var wish = false
    @State private var finishWish = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            EmitterView()
            modalContainer()
            
        }
    }
    
    
}

struct CongreteModalView_Previews: PreviewProvider {
    static var previews: some View {
        CongreteModalView()
    }
}

extension CongreteModalView {
    private func modalContainer() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(.horizontal, 35)
                        .padding(.top, 35)
                        .foregroundColor(Color.theme.teWhite)
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Perfect ")
                            .font(.custom("Inter-Bold", size: 32))
                            .foregroundColor(Color.theme.teSkyBlue)
                        Text("누적 횟수")
                            .font(.custom("Inter-Bold", size: 32))
                            .foregroundColor(Color.theme.teWhite)
                    }
                    Text("100개 달성")
                        .font(.custom("Inter-Bold", size: 32))
                        .foregroundColor(Color.theme.teWhite)
                }
                Spacer()
                Text("칭호를 획득했어요!")
                    .font(.custom("Inter-Regular", size: 20))
                    .foregroundColor(Color.theme.teWhite)
                    .padding(.bottom, 22)
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 264, height: 62)
                        .background(.black)
                        .cornerRadius(50)
                    Text("#레전드")
                        .font(.custom("Inter-Regular", size: 32))
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.theme.teSkyBlue, Color.theme.teGreen]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("#레전드")
                                    .font(.custom("Inter-Regular", size: 32))
                            )
                        )
                }
                Spacer()
                saveButton("적용")
            }
            .frame(maxHeight: 450)
        }
    }
    
    private func saveButton(_ buttonTitle: String) -> some View {
        
        return Button(action: {
            dismiss()
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color.theme.teGreen)
                    .cornerRadius(30)
                Text(buttonTitle)
                    .foregroundColor(Color.theme.teBlack)
                    .font(.custom("Inter-Bold", size: 16))
            }
            .padding(.horizontal, 18)
        }
    }
    
    private func doAnimation() {
        withAnimation(.spring()) {
            wish = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                finishWish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                finishWish = false
                wish = false
            }
        }
    }
}
