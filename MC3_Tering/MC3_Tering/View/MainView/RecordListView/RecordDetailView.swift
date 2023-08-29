//
//  RecordDetailView.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/08/28.
//

import SwiftUI

struct RecordDetailView: View {
    var detailDay: Date
    var totalSwingCount: Int
    var targetSwingCount: Int
    var perfectSwingCount: Int
    var workoutTime: Int
    var calorieBurn: Int
    
    var body: some View {
        ScrollView {
            chartContainer()
            dataTableContainer()
        }
        .navigationTitle(todayDateString)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .scrollIndicators(.hidden)
    }
}

struct RecordDetailView_Previewer: PreviewProvider {
    static var previews: some View {
        RecordDetailView(detailDay: Date(), totalSwingCount: 120, targetSwingCount: 240, perfectSwingCount: 80, workoutTime: 60, calorieBurn: 450)
    }
}

extension RecordDetailView {
    private var todayDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: detailDay)
    }
    
    private func chartContainer() -> some View {
        let totalSwing = Double(totalSwingCount) / Double(targetSwingCount) * 100
        let perfectStrokeRatio = Double(perfectSwingCount) / Double(totalSwingCount) * 100
        
        return VStack(spacing: 0) {
            ZStack {
                Circle()
                    .frame(maxWidth: UIScreen.main.bounds.width - 46, maxHeight: UIScreen.main.bounds.width - 46)
                    .foregroundColor(Color.theme.teRealBlack)
                VStack {
                    RingChartsView(values: [totalSwing, perfectStrokeRatio], colors: [[ Color.theme.teBlue, Color.theme.teGreen], [ Color.theme.teSkyBlue, Color.theme.teBlue]], ringsMaxValue: 100, lineWidth: 24, isAnimated: true)
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80, alignment: .center)
                }
                VStack(spacing: 0) {
                    Text("SWING")
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(Color.theme.teGreen)
                    Text("\(Int(totalSwingCount))/\(targetSwingCount)")
                        .font(.custom("Inter-Bold", size: 28))
                        .foregroundColor(Color.theme.teWhite)
                        .padding(.bottom, 14)
                    Text("PERFECT")
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(Color.theme.teSkyBlue)
                    Text("\(Int(perfectSwingCount))/\(Int(totalSwingCount))")
                        .font(.custom("Inter-Bold", size: 28))
                        .foregroundColor(Color.theme.teWhite)
                }
            }
            .padding(.top, 40)
            .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.width)
        }
    }
    
    private func dataTableContainer() -> some View {
        VStack(spacing: 0) {
            swingDataContainer("스윙 횟수", Color.theme.teGreen, false)
            swingDataContainer("Perfect 스윙", Color.theme.teBlue, true)
            timeCalorieDataContainer("운동 시간", workoutTime, true)
            timeCalorieDataContainer("칼로리 소비", calorieBurn, false)
        }
    }
    
    private func swingDataContainer(_ title: String, _ color: Color, _ isPerfect: Bool) -> some View {
        let totalPlaySwing = isPerfect ? perfectSwingCount : totalSwingCount
        let targetSwing = isPerfect ? totalSwingCount : targetSwingCount
        
        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(title)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 13)
                HStack(spacing: 0) {
                    Text("\(totalPlaySwing)/\(targetSwing)")
                        .font(.custom("Inter-SemiBold", size: 36))
                        .foregroundColor(color)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    Text("SWING")
                        .font(.custom("Inter-SemiBold", size: 24))
                        .foregroundColor(color)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, 3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.bottom, 15)
            
            Rectangle()
                .foregroundColor(Color.theme.teGray)
                .frame(height: 2)
                .padding(.leading, 30)
                .padding(.bottom, 16)
                
        }
    }
    
    private func timeCalorieDataContainer(_ title: String, _ data: Int, _ isTime: Bool) -> some View {
        let timeHour = workoutTime / 60
        let timeMinutes = workoutTime % 60
        
        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(title)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 13)
                if isTime {
                    HStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(timeHour)")
                                .font(.custom("Inter-SemiBold", size: 36))
                                .foregroundColor(Color.theme.teWhite)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                            Text("시간")
                                .font(.custom("Inter-SemiBold", size: 24))
                                .foregroundColor(Color.theme.teWhite)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom, 3)
                        }
                        
                        HStack(spacing: 0) {
                            Text("\(timeMinutes)")
                                .font(.custom("Inter-SemiBold", size: 36))
                                .foregroundColor(Color.theme.teWhite)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                            Text("분")
                                .font(.custom("Inter-SemiBold", size: 24))
                                .foregroundColor(Color.theme.teWhite)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom, 3)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    }
                    .padding(.bottom, 13)
                } else {
                    HStack(spacing: 0) {
                        Text("\(data)")
                            .font(.custom("Inter-SemiBold", size: 36))
                            .foregroundColor(Color.theme.teWhite)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        Text("kcal")
                            .font(.custom("Inter-SemiBold", size: 24))
                            .foregroundColor(Color.theme.teWhite)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 13)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            
            Rectangle()
                .foregroundColor(Color.theme.teGray)
                .frame(height: 2)
                .padding(.leading, 30)
                .padding(.bottom, 16)
        }
    }
}
