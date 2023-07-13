//
//  SwingListCellView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

struct SwingListCellView: View {
    let swingList: SwingList
    @State private var isGuideViewPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(systemName: swingList.guideButton)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.watchColor.lightGreen)
                    .padding(.top, 12)
                    .padding(.trailing, 6)
                    .onTapGesture {
                        isGuideViewPresented = true
                    }
                    .sheet(isPresented: $isGuideViewPresented) {
                        GuideView(swingList: swingList)
                    }
            }
            Spacer()
            Text(swingList.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.watchColor.lightGreen)
                .padding(.leading, 10)
                .padding(.bottom, 12)
        }
    }
}

struct SwingListCellView_Previews: PreviewProvider {
    static var previews: some View {
        SwingListCellView(swingList: swingLists[0])
    }
}
