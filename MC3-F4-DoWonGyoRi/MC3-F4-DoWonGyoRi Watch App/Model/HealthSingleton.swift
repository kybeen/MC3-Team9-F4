//
//  HealthSingleton.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/20.
//

import Foundation


class HealthStartInfo: ObservableObject {
    @Published var startCal: Double?
    @Published var startTime: Date?
}
