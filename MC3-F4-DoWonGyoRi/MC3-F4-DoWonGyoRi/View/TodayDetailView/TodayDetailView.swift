//
//  TodayDetailViewView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI

struct TodayDetailView: View {
    @State private var targetSwingCount = 120
    @State private var todaySwingCount = 135
    @State private var todayPerfectSwingCount = 34
    @State private var todayWorkoutTime = 120
    @State private var todayCalories = 200
    
    
    
    var body: some View {
        ScrollView {
            chartContainer()
            dataTableContainer()
        }
        .navigationTitle(todayDateString)
    }
}

struct TodayDetailView_Preview: PreviewProvider {
    static var previews: some View {
        TodayDetailView()

    }
}

extension TodayDetailView {
    private var todayDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: Date())
    }
    
    private func chartContainer() -> some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .frame(maxWidth: UIScreen.main.bounds.width - 46, maxHeight: UIScreen.main.bounds.width - 46)
                    .foregroundColor(Color.theme.teRealBlack)
                VStack {
                    RingChartsView(values: [220, 20], colors: [[Color.theme.teDarkGray, Color.theme.teGreen], [Color.theme.teLightGray, Color.theme.teBlue]], ringsMaxValue: 100, lineWidth: 24, isAnimated: true)
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80, alignment: .center)
                        
                }
                VStack(spacing: 0) {
                    Text("Perfect")
                        .font(.custom("Inter-Bold", size: 24))
                        .padding(.bottom, 12)
                        .foregroundColor(Color.theme.teSkyBlue)
                    Text("\(todayPerfectCount)회")
                        .font(.custom("Inter-Bold", size: 30))
                }
            }
            .padding(.top, 40)
            .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.width)
        }
    }
    
    private func dataTableContainer() -> some View {
        VStack(spacing: 0) {
            swingDataContainer("스윙 횟수", Color.theme.teGreen)
            swingDataContainer("Perfect 스윙", Color.theme.teBlue)
            timeCalorieDataContainer("운동 시간", todayWorkoutTime, true)
            timeCalorieDataContainer("칼로리 소비", todayCalories, false)
        }
    }
    
    private func swingDataContainer(_ title: String, _ color: Color) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(title)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 13)
                HStack(spacing: 0) {
                    Text("\(todaySwingCount)/\(targetSwingCount)")
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
        var timeHour = todayWorkoutTime / 60
        var timeMinutes = todayWorkoutTime % 60
        
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
