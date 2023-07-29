//
//  GuideView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

import SwiftUI

struct GuideView: View {
    let swingList: SwingList
    var body: some View {
        Image(systemName: swingList.gifImage)
            .resizable()
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(swingList: swingLists[0])
    }
}
