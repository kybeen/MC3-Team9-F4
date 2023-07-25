//
//  SwingList.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation

struct SwingList: Identifiable {
    var id: String { name }
    let name: String
    let guideButton: String
    let gifImage: String
}

let swingLists = [
    SwingList(name: "포핸드", guideButton: "questionmark.circle", gifImage: "square"),
    SwingList(name: "백핸드", guideButton: "questionmark.circle", gifImage: "square.fill"),
    SwingList(name: "서브(예정)", guideButton: "questionmark.circle", gifImage: "circle")
]


class SwingListWrapper: ObservableObject {
    @Published var swingList: SwingList
    
    init(swingList: SwingList) {
        self.swingList = swingList
    }
}
