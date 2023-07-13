//
//  UserStorkeSettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/13.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct UserStrokeSettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isBackhandSetting: Bool
    @State private var strokeCount = 10
    var body: some View {
        VStack(spacing: 0) {
            titleContainer("\(isBackhandSetting ? "백핸드" : "포핸드")")
            Spacer()
            countViewContainer()
            Spacer()
            saveButton("저장")
        }
        .padding(EdgeInsets(top: 80, leading: 25, bottom: 80, trailing: 25))
    }
}

extension UserStrokeSettingView {
    private func titleContainer(_ strokePosition: String) -> some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("목표 \(strokePosition) 스윙 횟수")
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(Color.theme.teWhite)
                Text("를")
                    .font(.custom("Inter-Medium", size: 24))
                    .foregroundColor(Color.theme.teWhite)
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            Text("설정해주세요.")
                .font(.custom("Inter-Medium", size: 24))
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .foregroundColor(Color.theme.teWhite)
        }
    }
    
    private func countViewContainer() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    if strokeCount > 10 {
                        strokeCount -= 10
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.teGreen)
                        .frame(maxWidth: 52)
                }
                Spacer()
                Text("\(strokeCount)")
                    .font(.custom("Inter-Bold", size: 52))
                    .foregroundColor(Color.theme.teWhite)
                Spacer()
                Button(action: {
                    if strokeCount < 300 {
                        strokeCount += 10
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.teGreen)
                        .frame(maxWidth: 52)
                }
            }
            .frame(maxWidth: 267)
            Text("회/일")
                .font(.custom("Inter-Medium", size: 24))
                .foregroundColor(Color.theme.teWhite)
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
                    .foregroundColor(.white)
                    .font(.custom("Inter-SemiBold", size: 16))
            }
        }
    }
    
    
}

struct UserStrokeSettingView_Preview: PreviewProvider {
    @State static var array: [Int] = []
    static var previews: some View {
        UserStrokeSettingView(isBackhandSetting: true)
    }
}
