//
//  MonthChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import Charts
import SwiftUI

struct MonthSwingData: Identifiable {
    let day: Date
    let count: Int
    
    var id: UUID = UUID()
}
struct MonthPerSwingDataType: Identifiable {
    let swingDataType: String
    let data: [MonthSwingData]
    
    var id: UUID = UUID()
}
let monthTotalSwingData: [MonthSwingData] = [
    .init(day: Date().date(2023, 7, 1), count: 100),
    .init(day: Date().date(2023, 7, 2), count: 106),
    .init(day: Date().date(2023, 7, 3), count: 103),
    .init(day: Date().date(2023, 7, 4), count: 120),
    .init(day: Date().date(2023, 7, 5), count: 85),
    .init(day: Date().date(2023, 7, 6), count: 90),
    .init(day: Date().date(2023, 7, 7), count: 100),
    .init(day: Date().date(2023, 7, 8), count: 130),
    .init(day: Date().date(2023, 7, 9), count: 150),
    .init(day: Date().date(2023, 7, 10), count: 160),
    .init(day: Date().date(2023, 7, 11), count: 130),
    .init(day: Date().date(2023, 7, 12), count: 122),
    .init(day: Date().date(2023, 7, 13), count: 116),
    .init(day: Date().date(2023, 7, 14), count: 134),
    .init(day: Date().date(2023, 7, 15), count: 123),
    .init(day: Date().date(2023, 7, 16), count: 115),
    .init(day: Date().date(2023, 7, 17), count: 87),
    .init(day: Date().date(2023, 7, 18), count: 98),
    .init(day: Date().date(2023, 7, 19), count: 105),
    .init(day: Date().date(2023, 7, 20), count: 145),
    .init(day: Date().date(2023, 7, 21), count: 169),
    .init(day: Date().date(2023, 7, 22), count: 78),
    .init(day: Date().date(2023, 7, 23), count: 138),
    .init(day: Date().date(2023, 7, 24), count: 153),
    .init(day: Date().date(2023, 7, 25), count: 123),
    .init(day: Date().date(2023, 7, 26), count: 134),
    .init(day: Date().date(2023, 7, 27), count: 153),
    .init(day: Date().date(2023, 7, 28), count: 99),
    .init(day: Date().date(2023, 7, 29), count: 87),
    .init(day: Date().date(2023, 7, 30), count: 70),
    .init(day: Date().date(2023, 7, 31), count: 80),
]
let monthPerfectSwingData: [MonthSwingData] = [
    .init(day: Date().date(2023, 7, 1), count: 90),
    .init(day: Date().date(2023, 7, 2), count: 100),
    .init(day: Date().date(2023, 7, 3), count: 97),
    .init(day: Date().date(2023, 7, 4), count: 110),
    .init(day: Date().date(2023, 7, 5), count: 73),
    .init(day: Date().date(2023, 7, 6), count: 78),
    .init(day: Date().date(2023, 7, 7), count: 90),
    .init(day: Date().date(2023, 7, 8), count: 110),
    .init(day: Date().date(2023, 7, 9), count: 134),
    .init(day: Date().date(2023, 7, 10), count: 147),
    .init(day: Date().date(2023, 7, 11), count: 115),
    .init(day: Date().date(2023, 7, 12), count: 110),
    .init(day: Date().date(2023, 7, 13), count: 100),
    .init(day: Date().date(2023, 7, 14), count: 112),
    .init(day: Date().date(2023, 7, 15), count: 115),
    .init(day: Date().date(2023, 7, 16), count: 108),
    .init(day: Date().date(2023, 7, 17), count: 77),
    .init(day: Date().date(2023, 7, 18), count: 82),
    .init(day: Date().date(2023, 7, 19), count: 94),
    .init(day: Date().date(2023, 7, 20), count: 120),
    .init(day: Date().date(2023, 7, 21), count: 150),
    .init(day: Date().date(2023, 7, 22), count: 70),
    .init(day: Date().date(2023, 7, 23), count: 130),
    .init(day: Date().date(2023, 7, 24), count: 141),
    .init(day: Date().date(2023, 7, 25), count: 115),
    .init(day: Date().date(2023, 7, 26), count: 120),
    .init(day: Date().date(2023, 7, 27), count: 135),
    .init(day: Date().date(2023, 7, 28), count: 90),
    .init(day: Date().date(2023, 7, 29), count: 82),
    .init(day: Date().date(2023, 7, 30), count: 65),
    .init(day: Date().date(2023, 7, 31), count: 70),
]
let monthPerSwingDataType: [MonthPerSwingDataType] = [
    .init(swingDataType: "전체 스윙 횟수", data: monthTotalSwingData),
    .init(swingDataType: "퍼펙트 스윙 횟수", data: monthPerfectSwingData)
]
//let totalSwingData: [WeekSwingData] = [
//    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 250),
//    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 124),
//    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 135),
//    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 104),
//    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 140),
//    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 90),
//    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 110),
//]
//let perfectSwingData: [WeekSwingData] = [
//    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 200),
//    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 100),
//    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 110),
//    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 90),
//    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 80),
//    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 70),
//    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 100),
//]
//let weekPerSwingDataType: [WeekPerSwingDataType] = [
//    .init(swingDataType: "전체 스윙 횟수", data: totalSwingData),
//    .init(swingDataType: "퍼펙트 스윙 횟수", data: perfectSwingData)
//]

struct MonthChartView: View {
    var monthTotalSwingAverage = 0 // 전체 스윙 평균
    var monthPerfectSwingAverage = 0 // 퍼펙트 스윙 평균
    
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
        monthTotalSwingAverage = totalSum / monthTotalSwingData.count
        monthPerfectSwingAverage = perfectSum / monthPerfectSwingData.count
    }
    
    var body: some View {
        Chart {
            ForEach(weekPerSwingDataType) { eachType in
                ForEach(eachType.data) { element in
                    BarMark(
                        x: .value("Week Day", element.weekday),
                        y: .value("Count", element.count),
                        stacking: .unstacked // 바 차트 겹쳐서 보기 위한 파라미터
                    )
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Swing Type", eachType.swingDataType))
                }
            }
            RuleMark(
                y:.value("Total Average", monthTotalSwingAverage)
            )
            .foregroundStyle(Color("TennisGreen"))
            .lineStyle(StrokeStyle(dash: [2]))
            
            RuleMark(
                y: .value("Perfect Average", monthPerfectSwingAverage)
            )
            .foregroundStyle(Color("TennisSkyBlue"))
            .lineStyle(StrokeStyle(dash: [2]))
        }
        .chartForegroundStyleScale([
            "전체 스윙 횟수": .linearGradient(colors: [Color("TennisGreen"), Color("TennisBlack")], startPoint: .init(x: 0.5, y: 0.0), endPoint: .init(x: 0.5, y: 0.8)),
            "퍼펙트 스윙 횟수": .linearGradient(colors: [Color("TennisSkyBlue"), Color("TennisBlack")], startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.9))
        ])
//            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
        .padding()
        .frame(height: UIScreen.main.bounds.height*0.5)
    }
}

struct MonthChartView_Previews: PreviewProvider {
    static var previews: some View {
        MonthChartView()
    }
}
