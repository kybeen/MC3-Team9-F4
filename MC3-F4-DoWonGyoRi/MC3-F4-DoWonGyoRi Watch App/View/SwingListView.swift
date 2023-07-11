//
//  SwingListView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

//MARK: - 화면 뷰

struct SwingListView: View {
    var body: some View {
        List {
            ForEach(swingLists) { swingList in
                SwingListCellView(swingList: swingList)
            }
            .frame(height: 108)
        }
    }
}

struct SwingListView_Previews: PreviewProvider {
    static var previews: some View {
        SwingListView()
    }
}
