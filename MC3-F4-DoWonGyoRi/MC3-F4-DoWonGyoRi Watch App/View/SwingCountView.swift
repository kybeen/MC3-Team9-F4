//
//  SwingCountView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

//MARK: - 시작 버튼 맨 밑으로 보내기

struct SwingCountView: View {
    let swingList: SwingList
    @State private var isReadyViewActive = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 목표 스윙 개수는\n얼마인가요?")
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            HStack {
                Text("개수 넣는 공간")
            }
            Spacer()
            NavigationLink(destination: ReadyView()) {
                Text("시작")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.black)
            }
            .background(Color.watchColor.lightGreen)
            .cornerRadius(40)
        }
        .navigationTitle("목록")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwingCountView_Previews: PreviewProvider {
    static var previews: some View {
        SwingCountView(swingList: swingLists[0])
    }
}
