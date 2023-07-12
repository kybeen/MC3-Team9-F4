//
//  CountingView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/12.
//

import SwiftUI

struct CountingView: View {
    var body: some View {
        TabView {
            //2. 여기에tabview안에 subview를 만들어주시면 됩니다.
            ZStack {
                Circle()
                    .frame(width: 150, height: 150, alignment: .center)
                VStack {
                    Text("남은 횟수")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.black)
                    Text("50")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(Color.black)
                }
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(0)

            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 94, height: 94)
                        .foregroundColor(Color.watchColor.lightRed)
                    Rectangle()
                        .frame(width: 38, height: 38, alignment: .center)
                        .foregroundColor(Color.watchColor.black)
                }
                .frame(alignment: .center)
                .padding(.bottom, 8)
                
                Text("종료")
                    .font(.system(size: 20, weight: .semibold))
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(1)
        }
        .navigationBarBackButtonHidden()
    }
}

struct CountingView_Previews: PreviewProvider {
    static var previews: some View {
        CountingView()
    }
}
