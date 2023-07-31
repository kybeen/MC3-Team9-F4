//
//  RecordChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/30.
//

import SwiftUI

struct RecordChartView: View {
    @State private var selectedPeriodIndex = 0
    private var periodSelections = ["1주", "1개월", "6개월", "1년"]
    
    var body: some View {
        VStack {
            CustomSegmentedView($selectedPeriodIndex, selections: periodSelections)
            
//            switch selectedPeriod {
//            case .week:
//                WeekChartview()
//            case .month:
//                MonthChartView()
//            case .sixMonths:
//                SixMonthsChartView()
//            case .year:
//                YearChartView()
//            }
        }
    }
}

struct RecordChartView_Previews: PreviewProvider {
    static var previews: some View {
        RecordChartView()
    }
}
