//
//  WeekChartview.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import Charts
import SwiftUI

struct WeekSwingData: Identifiable {
    let weekday: String
    let count: Int

    var id: UUID = UUID()
}
struct WeekPerSwingDataType: Identifiable {
    let swingDataType: String
    let data: [WeekSwingData]

    var id: UUID = UUID()
}
let totalSwingData: [WeekSwingData] = [
    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 250),
    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 124),
    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 135),
    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 104),
    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 140),
    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 90),
    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 110),
]
let perfectSwingData: [WeekSwingData] = [
    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 200),
    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 100),
    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 110),
    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 90),
    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 80),
    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 70),
    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 100),
]
let weekPerSwingDataType: [WeekPerSwingDataType] = [
    .init(swingDataType: "전체 스윙 횟수", data: totalSwingData),
    .init(swingDataType: "퍼펙트 스윙 횟수", data: perfectSwingData)
]

struct WeekChartview: View {
    var totalSwingAverage = 0 // 전체 스윙 평균
    var perfectSwingAverage = 0 // 퍼펙트 스윙 평균
    
    init() {
        var totalSum = 0
        var perfectSum = 0
        for each in weekPerSwingDataType {
            if each.swingDataType == "전체 스윙 횟수" {
                for eachData in each.data {
                    totalSum += eachData.count
                }
            } else {
                for eachData in each.data {
                    perfectSum += eachData.count
                }
            }
        }
        totalSwingAverage = totalSum / totalSwingData.count
        perfectSwingAverage = perfectSum / perfectSwingData.count
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeekChartview_Previews: PreviewProvider {
    static var previews: some View {
        WeekChartview()
    }
}
