//
//  CountingView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

//MARK: - tag0, tag1 위치 바꾸기

struct CountingView: View {
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    @State private var selectedTab = 1
//    @Binding var selectedValue: Int
    
    @EnvironmentObject var swingInfo: SwingInfo
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            QuitView()
                .tabItem{
                    Image(systemName: "tennisball.fill")
                        .foregroundColor(Color.watchColor.lightGreen)
                }
                .tag(0)
            
            ChekingSwingView()
                .tabItem{
                    Image(systemName: "tennisball.fill")
                        .foregroundColor(Color.watchColor.lightGreen)
                }
                .tag(1)
        }
        .onAppear {
            selectedTab = 1
            if tennisClassifierViewModel.isDetecting == false {
                tennisClassifierViewModel.startMotionTracking() // 동작 분류 모델 불러오기 및 모션 감지 시작
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//MARK: - 종료 뷰

struct QuitView: View {
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    @State var swingLeft: Int = 10
    
    @ObservedObject var healthManager = HealthKitManager()
    @EnvironmentObject var healthInfo: HealthStartInfo // Access the shared instance
    @EnvironmentObject var healthResultInfo: HealthResultInfo
    @ObservedObject var model = ViewModelWatch()
    
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
                getDayData()
                //                sendDataToPhone()
                tennisClassifierViewModel.stopMotionTracking() // 모션 감지 종료
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
        healthResultInfo.burningCal = Int(healthManager.currentCalories - (healthInfo.startCal ?? 0.0))
        print("결과 -> \(healthResultInfo.burningCal)")
    }
    
    private func getTimeData() {
        guard let startTime = healthInfo.startTime else { return }
        let currentTime = Date()
        print("시작 \(startTime), 지금 시간 \(currentTime)")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startTime, to: currentTime)
        
        if let timeDifferenceInMinutes = components.minute {
            healthResultInfo.workOutTime = timeDifferenceInMinutes
            print("시작 시간부터 현재까지의 시간 차이: \(healthResultInfo.workOutTime) 분")
        } else {
            print("시작 시간과 현재 시간 사이에 오류가 발생했습니다.")
        }
        
    }
    
    private func getDayData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 날짜 형식을 지정 (예: "2023-07-25")
        
        healthResultInfo.workOutDate = Date()
        print("날짜 -> \(healthResultInfo.workOutDate)")
        let formattedDate = dateFormatter.string(from: healthResultInfo.workOutDate!)
        print("오늘의 날짜: \(formattedDate)")
    }
    
    //    private func sendDataToPhone() {
    //        self.model.session.transferUserInfo(["calories" : self.healthResultInfo.burningCal])
    //        print("message send")
    //    }
    
}

//MARK: - 스윙 횟수 확인 뷰

struct ChekingSwingView: View {
    
//    @Binding var selectedValue: Int
    
    @State var progressValue: Float = 0.0
    @State var countValue: String = ""
    @State var fontSize: CGFloat = 48.0
    
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    @EnvironmentObject var swingInfo: SwingInfo
    
    
    var body: some View {
        ZStack {
//            TimeCircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: $fontSize)
//                .frame(width: 150, height: 150, alignment: .center)
            
//            Text("\(tennisClassifierViewModel.timestamp)").foregroundColor(.blue) //MARK: 테스트용
//
            //MARK: - TimeCircleProgressBar를 NavigationLink에 넣지 않으면 한 번 스윙한 뒤 멈춤
            // 스윙 결과 확인되면 MeasuringView로 넘어감
            NavigationLink(destination: MeasuringView(), isActive: tennisClassifierViewModel.isSwingBinding, label: {
                TimeCircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: $fontSize)
                    .frame(width: 150, height: 150, alignment: .center)
//                EmptyView()
            })
            .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove button visuals
            .background(Color.clear) // Make the background transparent
        }
        .onAppear {
            rate()
            countSwing()
        }
    }
}

extension ChekingSwingView {
    
    private func rate() {
        progressValue = Float(swingInfo.totalSwingCount ?? 0) / Float(swingInfo.selectedValue ?? 10)
        print("progressValue \(progressValue)")
    }
    
    private func countSwing() {
        countValue = "\(swingInfo.totalSwingCount ?? 0)"
        print("countValue -> \(countValue)")
    }
}


struct CountingView_Previews: PreviewProvider {
    
    static var previews: some View {
        CountingView()
    }
}
