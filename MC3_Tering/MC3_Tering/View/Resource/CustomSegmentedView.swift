//
//  CustomSegmentedView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import SwiftUI
import UIKit

//MARK: - 커스텀 Segmented Picker
struct CustomSegmentedView: View {
    @Binding var currentIndex: Int
    var selections: [String]
    
    init(_ currentIndex: Binding<Int>, selections: [String]) {
        self._currentIndex = currentIndex
        self.selections = selections
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "TennisGreen") // 선택 색상
//        UISegmentedControl.appearance().backgroundColor = UIColor(Color.orange.opacity(0.3)) // 배경 색상
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "TennisBlack")], for: .selected) // 선택 텍스트 색상
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "TennisWhite")], for: .normal) // 그 외 텍스트 색상
    }
    var body: some View {
        VStack {
            Picker("", selection: $currentIndex) {
                ForEach(selections.indices, id: \.self) { index in
                    Text(selections[index])
                        .tag(index)
                        .foregroundColor(Color.blue)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
}

//struct CustomSegmentedView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSegmentedView()
//    }
//}
