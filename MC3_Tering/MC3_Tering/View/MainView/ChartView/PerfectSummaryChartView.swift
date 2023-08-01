//
//  PerfectSummaryChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/08/01.
//

import Charts
import SwiftUI

//MARK: - 기록 탭뷰 하단 차트
struct PerfectSummaryChartView: View {
    var titleLabel: String
    var descriptionLabel: String
    var perfectSwingAverage: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Text(titleLabel)
                .font(.custom("Inter-Bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, minHeight: 277)
                    .background(Color.theme.teDarkGray)
                    .cornerRadius(13)
                    .padding(.top, 14)
                VStack(spacing: 0) {
                    Text("지난 \(descriptionLabel)간 총 Perfect Swing 수는 평균 \(perfectSwingAverage)회 입니다.")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.theme.teWhite)

                    Rectangle()
                        .frame(height: 0.5)
                        .padding(.top, 10)
                        .foregroundColor(Color.theme.teWhite)

                    Chart {
                        ForEach(weekPerfectSwingData) { element in
                            BarMark(
                                x:.value("Week Day", element.weekday),
                                y: .value("Count", element.count)
                            )
                            .cornerRadius(5)
                            .foregroundStyle(.linearGradient(colors: [Color("TennisSkyBlue"), Color.theme.teDarkGray], startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 1)))
                        }
                        RuleMark(
                            y: .value("Perfect Average", perfectSwingAverage)
                        )
                        .foregroundStyle(Color("TennisGreen"))
                        .lineStyle(StrokeStyle(dash: [2.5]))
                        .annotation(position: .leading, alignment: .leading) {
                            HStack(alignment: .bottom, spacing: 0) {
                                Text("\(perfectSwingAverage)")
                                    .font(.custom("Inter-SemiBold", size: 32))
                                Text("회")
                                    .font(.custom("Inter-SemiBold", size: 12))
                            }
                            .foregroundColor(Color("TennisGreen"))
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .frame(height: 160)
                    .padding(.top, 30)
                    .padding(.leading, 70)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
            }
        }
        .padding(.leading, 17)
        .padding(.trailing, 17)
    }
}

//struct PerfectSummaryChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        PerfectSummaryChartView()
//    }
//}
