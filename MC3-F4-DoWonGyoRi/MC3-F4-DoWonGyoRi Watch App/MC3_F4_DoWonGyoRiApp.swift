//
//  MC3_F4_DoWonGyoRiApp.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/07.
//

import SwiftUI

@main
struct MC3_F4_DoWonGyoRi_Watch_AppApp: App {
    @StateObject var swingListWrapper = SwingListWrapper(swingList: SwingList(name: "", guideButton: "", gifImage: ""))

    var body: some Scene {
        WindowGroup {
            SwingListView(swingList: swingLists[0])
                .environmentObject(swingListWrapper)
            //이거 왜 이러는거임?
        }
    }
}
