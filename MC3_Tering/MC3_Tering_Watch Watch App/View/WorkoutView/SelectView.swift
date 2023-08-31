//
//  SelectView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/28.
//

import SwiftUI

// MARK: - 운동 목표 달성 시 선택 화면
struct SelectView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var workoutResultInfo: WorkoutResultInfo
    
    @State var showResultView = false
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date())) { context in
            VStack(spacing: 0) {
                Text("목표를 달성했어요.\n연습을 끝내시겠어요?")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                Spacer()
                NavigationLink(destination: CountingView()) {
                    Text("이대로 계속하기")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.black)
                }
                .background(Color.watchColor.lightGreen)
                .cornerRadius(40)
                Spacer()
                
                NavigationLink(destination: ResultView(), isActive: $showResultView, label: {
                    Button("종료") {
                        // Workout 데이터 WorkoutResultInfo 모델에 저장 (운동 시간이 10초 이상일 때만 저장)
                        if Int(workoutManager.builder?.elapsedTime(at: context.date) ?? 0) >= 10 {
                            workoutResultInfo.workOutTime = Int(((workoutManager.builder?.elapsedTime(at: context.date) ?? 0) / 60).rounded()) // 운동 시간(초 -> 분 단위로 변환)
                            workoutResultInfo.burningCal = Int(workoutManager.activeEnergy.rounded()) // 소모 칼로리
                            workoutResultInfo.averageHeartRate = Int(workoutManager.averageHeartRate.rounded()) // 평균 심박수
                            workoutManager.isSaved = true
                        } else {
                            print("10초 미만의 운동 결과는 저장되지 않습니다. -> \(Int(workoutManager.builder?.elapsedTime(at: context.date) ?? 0))초")
                        }

                        workoutManager.endWorkout() // 운동 세션 및 모션 감지 종료
                        showResultView = true
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white)
                    .background(Color.watchColor.lightBlack)
                    .cornerRadius(40)
                })
                .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove button visuals
            }
            .padding(.horizontal, 5)
            .navigationBarBackButtonHidden()
        }
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
