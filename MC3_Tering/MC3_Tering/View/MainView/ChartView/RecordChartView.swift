//
//  RecordChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/30.
//

import SwiftUI
import Charts

enum Period: String, CaseIterable {
    case week // 1주
    case month // 1개월
    case sixMonths // 6개월
    case year // 1년
}

struct RecordChartView: View {
    @State private var selectedPeriod: Period = .week
    let periodLabels = [
        "week":"1주",
        "month":"1개월",
        "sixMonths":"6개월",
        "year":"1년"
    ]
    
    var body: some View {
        VStack {
            Picker("Select Period", selection: $selectedPeriod) {
                ForEach(Period.allCases, id: \.self) { category in
                    Text(periodLabels[category.rawValue]!)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selectedPeriod {
            case .week:
                Category1View()
            case .month:
                Category2View()
            case .sixMonths:
                Category3View()
            case .year:
                Category4View()
            }
        }
    }
}

struct RecordChartView_Previews: PreviewProvider {
    static var previews: some View {
        RecordChartView()
    }
}

struct Category1View: View {
    var body: some View {
        Chart {
            BarMark(
                x: .value("Name", "Cachapa")
            )
        }
    }
}

struct Category2View: View {
    var body: some View {
        Text("This is Category 2 View")
            .padding()
    }
}

struct Category3View: View {
    var body: some View {
        Text("This is Category 3 View")
            .padding()
    }
}

struct Category4View: View {
    var body: some View {
        Text("This is Category 4 View")
            .padding()
    }
}
