//
//  RecordChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/30.
//

import SwiftUI

enum Period {
    case week
    case month
    case sixMonths
    case year
}

struct RecordChartView: View {
    @State private var selectedPeriodIndex = 0
    private var periodSelections = ["1주", "1개월", "6개월", "1년"]
    
    var body: some View {
        VStack {
            CustomSegmentedView($selectedPeriodIndex, selections: periodSelections)
            
            switch selectedPeriodIndex {
            case 0:
                WeekChartview()
            case 1:
                MonthChartView()
            case 2:
                SixMonthsChartView()
            case 3:
                YearChartView()
            default:
                Text("차트를 불러오지 못했습니다.")
            }
        }
    }
}

struct RecordChartView_Previews: PreviewProvider {
    static var previews: some View {
        RecordChartView()
    }
}
