//
//  ResultView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        TabView {
            VStack {
                Text("여기 폭죽 터지고 난리내기")
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(0)
            
            VStack {
                Text("PERFECT, BAD 개수")
                    .font(.system(size: 20, weight: .semibold))
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(1)
            
            VStack {
                Text("운동 요약")
                //MARK: - 이 버튼 없으면 정중앙에 정렬됨
                NavigationLink(destination: CompleteView()) {
                    Text("완료 버튼")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.black)
                }
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(2)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
