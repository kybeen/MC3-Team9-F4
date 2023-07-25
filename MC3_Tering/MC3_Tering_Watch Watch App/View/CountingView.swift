//
//  CountingView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

//MARK: - tag0, tag1 위치 바꾸기

struct CountingView: View {
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            QuitView()
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(0)
            
            ZStack {
                Circle()
                    .frame(width: 150, height: 150, alignment: .center)
                VStack(spacing: -8) {
                    Text("남은 횟수")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.black)
                    Text("50")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(Color.black)
                    
                    //MARK: - 이 버튼 없으면 정중앙에 정렬됨
                    NavigationLink(destination: MeasuringView()) {
                        Text("시작")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.black)
                    }
                }
            }
            .tabItem{
                Image(systemName: "tennisball.fill")
                    .foregroundColor(Color.watchColor.lightGreen)
            }
            .tag(1)
        }
        .onAppear {
            selectedTab = 1
        }
        .navigationBarBackButtonHidden()
    }
}

struct QuitView: View {
    
    @State var swingLeft: Int = 10
    
    @ObservedObject var healthManager = HealthKitManager()
    @EnvironmentObject var healthInfo: HealthStartInfo // Access the shared instance
    @EnvironmentObject var healthResultInfo: HealthResultInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(swingLeft)번의 스윙이 남았어요.\n연습을 끝내시겠어요?")
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            
            NavigationLink(destination: ResultView()) {
                Text("종료")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white)
            }
            .background(Color.watchColor.lightBlack)
            .cornerRadius(40)
            .onDisappear {
                getCaloryData()
                getTimeData()
            }
        }
        .onAppear {
            healthManager.readCurrentCalories()
        }
    }
}

extension QuitView {

    private func getCaloryData() {
        print("처음 -> \(healthInfo.startCal)")
        print("나중 -> \(healthManager.currentCalories)")
        healthResultInfo.consumedCal = Int(healthManager.currentCalories - (healthInfo.startCal ?? 0.0))
        print("결과 -> \(healthResultInfo.consumedCal)")
    }
    
    private func getTimeData() {
        guard let startTime = healthInfo.startTime else { return }
        let currentTime = Date()
        print("시작 \(startTime), 지금 시간 \(currentTime)")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startTime, to: currentTime)

        if let timeDifferenceInMinutes = components.minute {
            healthResultInfo.timeSpentMinute = timeDifferenceInMinutes
            print("시작 시간부터 현재까지의 시간 차이: \(healthResultInfo.timeSpentMinute) 분")
        } else {
            print("시작 시간과 현재 시간 사이에 오류가 발생했습니다.")
        }
        
    }
    
}

struct CountingView_Previews: PreviewProvider {
    static var previews: some View {
        CountingView()
    }
}
