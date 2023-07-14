//
//  SwingListView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

//MARK: - 화면 뷰
//MARK: - 리스트 바꾸기 (그 운동 앱 처럼)

struct SwingListView: View {
    let swingList: SwingList
    var body: some View {
        NavigationStack {
            List(swingLists) { swingList in
                NavigationLink(destination: SwingCountView(swingList: swingList)) {
                    SwingListCellView(swingList: swingList)
                }
                .frame(height: 120)
            }
            .cornerRadius(20)
            
            //추후에 색상 변경 가능
            .navigationTitle("자세")
            //우선 야매로,,
            .navigationBarBackButtonHidden()
        }
    }
}

struct SwingListView_Previews: PreviewProvider {
    static var previews: some View {
        SwingListView(swingList: swingLists[0])
    }
}
