//
//  HealthResultInfo.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation

class HealthResultInfo: ObservableObject {
    @Published var burningCal: Int?
    @Published var workOutTime: Int?
    @Published var workOutDate: Date?
}
