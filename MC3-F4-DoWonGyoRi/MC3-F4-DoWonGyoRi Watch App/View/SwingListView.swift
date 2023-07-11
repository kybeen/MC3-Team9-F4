//
//  SwingListView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

//MARK: - 화면 뷰

struct SwingListView: View {
    let swingList: SwingList
    var body: some View {
        NavigationView {
            List(swingLists) { swingList in
                NavigationLink(destination: SwingCountView(swingList: swingList)) {
                    SwingListCellView(swingList: swingList)
                }
                .frame(height: 108)
            }
        }
    }
}

struct SwingListView_Previews: PreviewProvider {
    static var previews: some View {
        SwingListView(swingList: swingLists[0])
    }
}
