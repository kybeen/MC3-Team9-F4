//
//  RecordListView.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/08/28.
//

import SwiftUI

struct RecordListView: View {
    let months = ["2023년 7월", "2023년 8월", "2023년 9월"] // 월 데이터
    
    var body: some View {
        List {
            ForEach(months, id: \.self) { month in
                Section(header: Text(month)) {
                    ForEach(1..<32, id: \.self) { day in
                        Text("\(day)일")
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Sectioned List Example")
    }
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
