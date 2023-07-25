//
//  TodayDetailView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct TodayDetailView: View {
    @ObservedObject var workoutDataModel: WorkOutDataModel
    @ObservedObject var userDataModel: UserDataModel
    @StateObject private var cameraViewModel: CameraViewModel

    init(workoutDataModel: WorkOutDataModel, userDataModel: UserDataModel) {
        self.workoutDataModel = workoutDataModel
        self.userDataModel = userDataModel
        // ✅ 추가: 기존의 workoutDataModel을 전달하여 CameraViewModel 초기화
        _cameraViewModel = StateObject(wrappedValue: CameraViewModel(workoutDataModel: workoutDataModel))
    }

    var body: some View {
        ScrollView {
            chartContainer()
            dataTableContainer()
        }
        .navigationTitle(todayDateString)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarItems(trailing: NavigationLink(destination: CameraView(viewModel: cameraViewModel, workoutDataModel: workoutDataModel)) {
            Image("instagram_icon")
        })
        .scrollIndicators(.hidden)
    }
}

extension TodayDetailView {
    private var todayDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: Date())
    }
    
    private func chartContainer() -> some View {
        let totalSwing = (workoutDataModel.todayChartDatum[6]) / Double(userDataModel.userTargetBackStroke + userDataModel.userTargetForeStroke) * 100
        let perfectStrokeRatio = workoutDataModel.todayChartDatum[7] * 100
        
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
                    Text("Swing 달성도")
                        .font(.custom("Inter-Bold", size: 24))
                        .padding(.bottom, 12)
                        .foregroundColor(Color.theme.teGreen)
                    Text("\(totalSwing, specifier: "%0.1f")%")
                        .font(.custom("Inter-Bold", size: 28))
                        .foregroundColor(Color.theme.teWhite)
                        .padding(.bottom, 20)
                    Text("Perfect")
                        .font(.custom("Inter-Bold", size: 24))
                        .padding(.bottom, 12)
                        .foregroundColor(Color.theme.teSkyBlue)
                    Text("\(Int(workoutDataModel.todayChartDatum[0] + workoutDataModel.todayChartDatum[3]))회(\(perfectStrokeRatio, specifier: "%0.1f")%)")
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
            timeCalorieDataContainer("운동 시간", Int(workoutDataModel.todayChartDatum[8]), true)
            timeCalorieDataContainer("칼로리 소비", Int(workoutDataModel.todayChartDatum[11]), false)
        }
    }
    
    private func swingDataContainer(_ title: String, _ color: Color, _ isPerfect: Bool) -> some View {
        let totalPlaySwing = isPerfect ? Int(workoutDataModel.todayChartDatum[0] + workoutDataModel.todayChartDatum[3]) : Int(workoutDataModel.todayChartDatum[6])
        let targetSwing = isPerfect ? Int(workoutDataModel.todayChartDatum[6]) : userDataModel.userTargetBackStroke + userDataModel.userTargetForeStroke
        
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
        let timeHour = Int(workoutDataModel.todayChartDatum[8]) / 60
        let timeMinutes = Int(workoutDataModel.todayChartDatum[8]) % 60
        
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
