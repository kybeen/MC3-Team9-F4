//
//  CompareChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/08/02.
//

import SwiftUI

//MARK: - 기록 탭뷰 하단 비교 차트
struct CompareChartView: View {
    var periodLabel1: String // 기간 라벨1
    var periodLabel2: String // 기간 라벨2
    var swingLabel: String // 포핸드 / 백핸드
    var raisedCount: Int // 몇 회 늘었는지(줄었는지)
    var raiseState: Bool // '늘었습니다' '줄었습니다' 정하는 변수
    var raiseLabel: String {
        if raiseState {
            return "늘었습니다"
        } else {
            return "줄었습니다"
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 254)
                .background(Color("TennisDarkGray"))
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("\(periodLabel1) \(swingLabel) Perfect Swing 수가\n\(periodLabel2)보다 \(raisedCount)회 \(raiseLabel).")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)
    
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 10)
                    .foregroundColor(Color.theme.teWhite)
                
                SummaryCompareBox(selfValue: 430, compareValue: 180, leftColor: Color("TennisBlack"), rightColor: Color("TennisSkyBlue"), startMonth: 7, startDay: 4, endMonth: 7, endDay: 11)
                SummaryCompareBox(selfValue: 180, compareValue: 430, leftColor: Color("TennisBlack"), rightColor: Color("TennisWhite"), startMonth: 6, startDay: 28, endMonth: 7, endDay: 4)
            }
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
        .frame(alignment: .leading)
    }
}

//struct CompareChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompareChartView()
//    }
//}

//MARK: - 움직이는 막대 뷰
struct SummaryCompareBox: View {
    let screenSize = UIScreen.main.bounds.width
    
    var selfValue: Int // 기준값
    var compareValue: Int // 비교값
    var leftColor: Color = Color("TennisWhite") // 그라데이션 왼쪽 색
    var rightColor: Color = Color("TennisWhite") // 그라데이션 오른쪽 색
    
    var startMonth: Int
    var startDay: Int
    var endMonth: Int
    var endDay: Int
    
    @State var isAnimationEnabled = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Text("\(selfValue)")
                    .font(.custom("Inter-SemiBold", size: 30))
                    .foregroundColor(Color("TennisWhite"))
                Text("회")
                    .font(.custom("Inter-SemiBold", size: 24))
                    .foregroundColor(Color("TennisWhite"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: sizeCalculate(CGFloat(selfValue), CGFloat(compareValue)), maxHeight: 23)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: rightColor, location: 0.00),
                                    Gradient.Stop(color: leftColor, location: 1.00)
                                ],
                                startPoint: UnitPoint(x: 1, y: 0.52),
                                endPoint: UnitPoint(x: -0.06, y: 0.52)
                            )
                        )
                        .cornerRadius(5)
                        .overlay(
                            Text("\(startMonth)/\(startDay)~\(endMonth)/\(endDay)")
                                .foregroundColor(.black)
                                .font(.custom("Inter-SemiBold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 16)
                                
                        )
                        .scaleEffect(x: isAnimationEnabled ? 1 : 0, y: 1, anchor: .leading)
                        .animation(.easeOut(duration: isAnimationEnabled ? 2 : 0), value: isAnimationEnabled)
                        .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    // 애니메이션 활성화
                    if isAnimationEnabled {
                        isAnimationEnabled = false
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            isAnimationEnabled = true
                        }
                    }
                }
            }
        }
    }
}

extension SummaryCompareBox {
    func sizeCalculate(_ A: CGFloat, _ B: CGFloat) -> CGFloat {
        if A == 0 || B == 0 {
            return CGFloat(45)
        }
        print("막대그래프 길이 : ",CGFloat(A / B * screenSize) < 60 ? 60 : CGFloat(A / B * screenSize))
        return CGFloat(A / B * screenSize) < 45 ? 45 : CGFloat(A / B * screenSize)
        
    }
}
