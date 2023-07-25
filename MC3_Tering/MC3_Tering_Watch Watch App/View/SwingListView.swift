//
//  SwingListView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
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
            .foregroundColor(Color.watchColor.lightBlack)
            .listStyle(CarouselListStyle())
            .cornerRadius(15)
            
            //추후에 색상 변경 가능
            .navigationTitle("자세")
            
            //MARK: - 클린 코드
            .navigationBarBackButtonHidden()
        }
    }
}

struct SwingListView_Previews: PreviewProvider {
    static var previews: some View {
        SwingListView(swingList: swingLists[0])
    }
}
