//
//  SwingInfo.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/27.
//

import Foundation

class SwingInfo: ObservableObject {
    @Published var totalSwingCount: Int?
    @Published var forehandPerfect: Int?
    @Published var totalForehandCount: Int?
    @Published var backhandPerfect: Int?
    @Published var totalBackhandCount: Int?
    @Published var selectedValue: Int? // 목표 스윙 횟수
    @Published var swingLeft: Int? // 남은 스윙 횟수
}

