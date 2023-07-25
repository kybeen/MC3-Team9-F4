//
//  CountingView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

//MARK: - tag0, tag1 위치 바꾸기

struct CountingView: View {
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            QuitView()
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(0)
            
            ZStack {
                Circle()
                    .frame(width: 150, height: 150, alignment: .center)
                VStack(spacing: -8) {
                    Text("남은 횟수")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.black)
                    Text("50")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(Color.black)
                    
                    //MARK: - 이 버튼 없으면 정중앙에 정렬됨
                    NavigationLink(destination: MeasuringView()) {
                        Text("시작")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.black)
                    }
                }
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(1)
        }
        .onAppear {
            selectedTab = 1
        }
        .navigationBarBackButtonHidden()
    }
}

struct QuitView: View {
    
    @State var swingLeft: Int = 10
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(swingLeft)번의 스윙이 남았어요.\n연습을 끝내시겠어요?")
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            
            NavigationLink(destination: ResultView()) {
                Text("종료")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white)
            }
            .background(Color.watchColor.lightBlack)
            .cornerRadius(40)
        }
    }
}

struct CountingView_Previews: PreviewProvider {
    static var previews: some View {
        CountingView()
    }
}
