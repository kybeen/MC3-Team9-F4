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
let weekTotalSwingData: [WeekSwingData] = [
    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 250),
    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 124),
    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 135),
    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 104),
    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 140),
    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 90),
    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 110),
]
let weekPerfectSwingData: [WeekSwingData] = [
    .init(weekday: Date().date(2023,7,24).getWeekday(), count: 200),
    .init(weekday: Date().date(2023,7,25).getWeekday(), count: 100),
    .init(weekday: Date().date(2023,7,26).getWeekday(), count: 110),
    .init(weekday: Date().date(2023,7,27).getWeekday(), count: 90),
    .init(weekday: Date().date(2023,7,28).getWeekday(), count: 80),
    .init(weekday: Date().date(2023,7,29).getWeekday(), count: 70),
    .init(weekday: Date().date(2023,7,30).getWeekday(), count: 100),
]
let weekPerSwingDataType: [WeekPerSwingDataType] = [
    .init(swingDataType: "전체 스윙 횟수", data: weekTotalSwingData),
    .init(swingDataType: "퍼펙트 스윙 횟수", data: weekPerfectSwingData)
]

struct WeekChartview: View {
    var weekTotalSwingAverage = 0 // 전체 스윙 평균
    var weekPerfectSwingAverage = 0 // 퍼펙트 스윙 평균
    
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
        weekTotalSwingAverage = totalSum / weekTotalSwingData.count
        weekPerfectSwingAverage = perfectSum / weekPerfectSwingData.count
    }
    
    var body: some View {
        VStack {
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
                    y:.value("Total Average", weekTotalSwingAverage)
                )
                .foregroundStyle(Color("TennisGreen"))
                .lineStyle(StrokeStyle(dash: [2]))
                
                RuleMark(
                    y: .value("Perfect Average", weekPerfectSwingAverage)
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
            
            PerfectSummaryChartView(titleLabel: "주간 활동", descriptionLabel: "7일", perfectSwingAverage: weekPerfectSwingAverage)
        }
    }
}

struct WeekChartview_Previews: PreviewProvider {
    static var previews: some View {
        WeekChartview()
    }
}
