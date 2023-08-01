//
//  YearChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import Charts
import SwiftUI

let yearTotalSwingData: [ManyMonthsSwingData] = [
    .init(month: Date().date2(2023, 1).getMonth(), count: 900),
    .init(month: Date().date2(2023, 2).getMonth(), count: 1000),
    .init(month: Date().date2(2023, 3).getMonth(), count: 1400),
    .init(month: Date().date2(2023, 4).getMonth(), count: 600),
    .init(month: Date().date2(2023, 5).getMonth(), count: 1100),
    .init(month: Date().date2(2023, 6).getMonth(), count: 700),
    .init(month: Date().date2(2023, 7).getMonth(), count: 850),
    .init(month: Date().date2(2023, 8).getMonth(), count: 700),
    .init(month: Date().date2(2023, 9).getMonth(), count: 760),
    .init(month: Date().date2(2023, 10).getMonth(), count: 880),
    .init(month: Date().date2(2023, 11).getMonth(), count: 1000),
    .init(month: Date().date2(2023, 12).getMonth(), count: 930),
]
let yearPerfectSwingData: [ManyMonthsSwingData] = [
    .init(month: Date().date2(2023, 1).getMonth(), count: 600),
    .init(month: Date().date2(2023, 2).getMonth(), count: 900),
    .init(month: Date().date2(2023, 3).getMonth(), count: 1050),
    .init(month: Date().date2(2023, 4).getMonth(), count: 430),
    .init(month: Date().date2(2023, 5).getMonth(), count: 800),
    .init(month: Date().date2(2023, 6).getMonth(), count: 500),
    .init(month: Date().date2(2023, 7).getMonth(), count: 700),
    .init(month: Date().date2(2023, 8).getMonth(), count: 580),
    .init(month: Date().date2(2023, 9).getMonth(), count: 400),
    .init(month: Date().date2(2023, 10).getMonth(), count: 500),
    .init(month: Date().date2(2023, 11).getMonth(), count: 760),
    .init(month: Date().date2(2023, 12).getMonth(), count: 770),
]
let yearPerSwingDataType: [ManyMonthsPerSwingDataType] = [
    .init(swingDataType: "전체 스윙 횟수", data: yearTotalSwingData),
    .init(swingDataType: "퍼펙트 스윙 횟수", data: yearPerfectSwingData)
]

struct YearChartView: View {
    var yearTotalSwingAverage = 0 // 전체 스윙 평균
    var yearPerfectSwingAverage = 0 // 퍼펙트 스윙 평균
    
    init() {
        var totalSum = 0
        var perfectSum = 0
        for each in yearPerSwingDataType {
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
        yearTotalSwingAverage = totalSum / yearTotalSwingData.count
        yearPerfectSwingAverage = perfectSum / yearPerfectSwingData.count
    }
    
    var body: some View {
        Chart {
            ForEach(yearPerSwingDataType) { eachType in
                ForEach(eachType.data) { element in
                    BarMark(
                        x: .value("Month", element.month),
                        y: .value("Count", element.count),
                        stacking: .unstacked // 바 차트 겹쳐서 보기 위한 파라미터
                    )
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Swing Type", eachType.swingDataType))
                }
            }
            RuleMark(
                y:.value("Total Average", yearTotalSwingAverage)
            )
            .foregroundStyle(Color("TennisGreen"))
            .lineStyle(StrokeStyle(dash: [2]))
            
            RuleMark(
                y: .value("Perfect Average", yearPerfectSwingAverage)
            )
            .foregroundStyle(Color("TennisSkyBlue"))
            .lineStyle(StrokeStyle(dash: [2]))
        }
        .chartYAxis {
            AxisMarks(preset: .extended)
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

struct YearChartView_Previews: PreviewProvider {
    static var previews: some View {
        YearChartView()
    }
}
