//
//  OnboardingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            titleContainer("프로필", "을", "입력해주세요.")
            Spacer()
            welcomeCommentContainer()
                .padding(.horizontal, 24)
            Spacer()
            nextButton()
        }
        .frame(maxHeight: 600)
    }
}

struct OnboardingView_Previewer: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

extension OnboardingView {
    private func titleContainer(_ boldString: String, _ normalString1: String = "", _ normalString2: String = "") -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(boldString)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teWhite)
                Text(normalString1)
                    .font(.custom("Inter-Medium", size: 28))
                    .foregroundColor(Color.theme.teWhite)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(normalString2)
                .font(.custom("Inter-Medium", size: 28))
                .foregroundColor(Color.theme.teWhite)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 30)
    }
    
    private func welcomeCommentContainer() -> some View {
        ZStack(alignment: .center) {
            VStack(spacing: 0) {
                Text("테니스 플레이어님\n환영합니다!")
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                Spacer()
                Rectangle()
                    .foregroundColor(Color.theme.teWhite)
                    .frame(height: 1)
                Spacer()
                Text("Tering은 당신에게 알맞은 테니스 자세와\n성장의 기록을 제공합니다.\nTering과 함께 즐거운 테니스 생활을\n시작해봅시다!")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
    }
    
    private func nextButton(_ buttonTitle: String = "다음") -> some View {
        Button(action: {
            
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .background(Color.theme.teGreen)
                    .cornerRadius(30)
                Text(buttonTitle)
                    .foregroundColor(Color.theme.teBlack)
                    .font(.custom("Inter-Bold", size: 16))
            }
        }
    }
}
