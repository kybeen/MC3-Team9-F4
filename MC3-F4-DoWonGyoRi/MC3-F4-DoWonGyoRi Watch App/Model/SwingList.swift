//
//  SwingList.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import Foundation

struct SwingList: Identifiable {
    var id: String { name }
    let name: String
    let guideButton: String
    let gifImage: String
}

let swingLists = [
    SwingList(name: "포핸드", guideButton: "questionmark.circle", gifImage: "heart.fill"),
    SwingList(name: "백핸드", guideButton: "questionmark.circle", gifImage: "heart"),
    SwingList(name: "서브(예정)", guideButton: "questionmark.circle", gifImage: "circle")
]
