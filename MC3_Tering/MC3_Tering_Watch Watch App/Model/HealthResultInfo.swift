//
//  HealthResultInfo.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation

class HealthResultInfo: ObservableObject {
    @Published var averageHeartRate: Int? // 평균 심박수
    @Published var burningCal: Int? // 소모 칼로리
    @Published var workOutTime: Int? // 운동 시간
    @Published var workOutDate: Date? // 운동일
}

