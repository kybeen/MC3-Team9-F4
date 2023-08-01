//
//  SixMonthsChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import Charts
import SwiftUI

struct ManyMonthsSwingData: Identifiable {
    let month: String
    let count: Int

    var id: UUID = UUID()
}
struct ManyMonthsPerSwingDataType: Identifiable {
    let swingDataType: String
    let data: [ManyMonthsSwingData]

    var id: UUID = UUID()
}
let sixMonthsTotalSwingData: [ManyMonthsSwingData] = [
    .init(month: Date().date2(2023, 2).getMonth(), count: 1000),
    .init(month: Date().date2(2023, 3).getMonth(), count: 1400),
    .init(month: Date().date2(2023, 4).getMonth(), count: 600),
    .init(month: Date().date2(2023, 5).getMonth(), count: 1100),
    .init(month: Date().date2(2023, 6).getMonth(), count: 700),
    .init(month: Date().date2(2023, 7).getMonth(), count: 850),
]
let sixMonthsPerfectSwingData: [ManyMonthsSwingData] = [
    .init(month: Date().date2(2023, 2).getMonth(), count: 900),
    .init(month: Date().date2(2023, 3).getMonth(), count: 1050),
    .init(month: Date().date2(2023, 4).getMonth(), count: 430),
    .init(month: Date().date2(2023, 5).getMonth(), count: 800),
    .init(month: Date().date2(2023, 6).getMonth(), count: 500),
    .init(month: Date().date2(2023, 7).getMonth(), count: 700),
]
let sixMonthsPerSwingDataType: [ManyMonthsPerSwingDataType] = [
    .init(swingDataType: "전체 스윙 횟수", data: sixMonthsTotalSwingData),
    .init(swingDataType: "퍼펙트 스윙 횟수", data: sixMonthsPerfectSwingData)
]

struct SixMonthsChartView: View {
    var sixMonthsTotalSwingAverage = 0 // 전체 스윙 평균
    var sixMonthsPerfectSwingAverage = 0 // 퍼펙트 스윙 평균
    
    init() {
        var totalSum = 0
        var perfectSum = 0
        for each in sixMonthsPerSwingDataType {
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
        sixMonthsTotalSwingAverage = totalSum / sixMonthsTotalSwingData.count
        sixMonthsPerfectSwingAverage = perfectSum / sixMonthsPerfectSwingData.count
    }
    
    var body: some View {
        Chart {
            ForEach(sixMonthsPerSwingDataType) { eachType in
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
                y:.value("Total Average", sixMonthsTotalSwingAverage)
            )
            .foregroundStyle(Color("TennisGreen"))
            .lineStyle(StrokeStyle(dash: [2]))
            
            RuleMark(
                y: .value("Perfect Average", sixMonthsPerfectSwingAverage)
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

struct SixMonthsChartView_Previews: PreviewProvider {
    static var previews: some View {
        SixMonthsChartView()
    }
}
