//
//  CompareChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/08/02.
//

import SwiftUI

//MARK: - 기록 탭뷰 하단 비교 차트
struct CompareChartView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 254)
                .background(Color("TennisDarkGray"))
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("지난 7일간 총 Perfect Swing 수는 평균 120회입니다.")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)
    
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 10)
                    .foregroundColor(Color.theme.teWhite)
    
//                horizontalBarGraphContainer(todayPerfect, yesterdayPerfect, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue, false, true)
//                horizontalBarGraphContainer(yesterdayPerfect, todayPerfect, false, false)
            }
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
}

struct CompareChartView_Previews: PreviewProvider {
    static var previews: some View {
        CompareChartView()
    }
}

//private func summaryCountBox(_ firstLineString: String, _ compareString: String, _ isBackhand: Bool) -> some View {
//    let todayPerfect = Int(workoutDataModel.todayChartDatum[isBackhand ? 3 : 0])
//    let yesterdayPerfect = Int(workoutDataModel.todayChartDatum[isBackhand ? 4 : 1])
//    let difference = Int(workoutDataModel.todayChartDatum[isBackhand ? 5 : 2])
//
//    return ZStack {
//        Rectangle()
//            .foregroundColor(.clear)
//            .frame(maxWidth: .infinity, minHeight: 254)
//            .background(Color.theme.teDarkGray)
//            .cornerRadius(13)
//            .padding(.top, 14)
//        VStack(spacing: 0) {
//            Text("\(firstLineString) \(compareString)\n\(abs(difference))회 \(difference > 0 ? "늘었습니다" : "줄었습니다").")
//                .font(.custom("Inter-SemiBold", size: 16))
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .foregroundColor(Color.theme.teWhite)
//
//            Rectangle()
//                .frame(height: 0.5)
//                .padding(.top, 10)
//                .foregroundColor(Color.theme.teWhite)
//
//            horizontalBarGraphContainer(todayPerfect, yesterdayPerfect, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue, false, true)
//            horizontalBarGraphContainer(yesterdayPerfect, todayPerfect, false, false)
//        }
//        .frame(alignment: .leading)
//        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
//    }
//}
