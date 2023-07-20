//
//  MainView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI
import Charts

let title1 = "Title1"
let title2 = "Title2"
let nickname = "배승현"
let suffix = "님"

struct MainView: View {
    @ObservedObject var userDataModel = UserDataModel.shared
    @ObservedObject var workoutDataModel = WorkOutDataModel.shared
    
    @State private var selectedTab = 0
    @State var isAnimationEnabled = false
    @State var isGuidePresent = false
    @State private var path: [Int] = []
    
    @State private var isCongretePresented = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                containerView()
                namespaceContainer()
                
                VStack(spacing: 0) {
                    tabsContainer()
                    tabViewContainer()
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                userDataModel.fetchUserData()
                print(workoutDataModel.todayChartDatum)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isAnimationEnabled = true
                }
                
            }
            .onDisappear {
                userDataModel.saveUserData()
            }
        }
        .sheet(isPresented: $isCongretePresented, content: {
            CongreteModalView()
                .presentationDetents([.fraction(0.7), .fraction(0.7)])
        })
    }
        
}


extension MainView {
    private func containerView() -> some View {
        HStack {
            Button(action: {
                isGuidePresent.toggle()
            }) {
                Image(systemName: "figure.tennis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.theme.teGreen)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 27)
            }
            .fullScreenCover(isPresented: $isGuidePresent, content: GuideView.init)
            Spacer()
            NavigationLink(destination: SettingView()) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.theme.teWhite)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 27)
            }
            
        }
        .padding(.top, 15)
    }
    
    private func namespaceContainer() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("어서오세요")
                .font(.custom("Inter-SemiBold", size: 28))
                .padding(.bottom, 2)
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(userDataModel.userTitle1)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.trailing, 10)
                Text(userDataModel.userTitle2)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teSkyBlue)
                    .padding(.trailing, 10)
                Text(userDataModel.username + suffix)
                    .font(.custom("Inter-SemiBold", size: 28))
                    .foregroundColor(Color.theme.teWhite)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 150, alignment: .leading)
        .padding(.leading, 27)
    
    }
    
    private func tabsContainer() -> some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedTab = 0
            }) {
                VStack(spacing: 3) {
                    Text("오늘의 스윙")
                        .font(.custom("Inter-medium", size: 20))
                        .foregroundColor(selectedTab == 0 ? Color.theme.teGreen : Color.theme.teWhite)
                    Rectangle()
                        .frame(maxWidth: 118, maxHeight: 3)
                        .foregroundColor(selectedTab == 0 ? Color.theme.teGreen : Color.theme.teBlack)
                }
                .frame(maxWidth: 100)
            }
            Button(action: {
                selectedTab = 1
            }) {
                VStack(spacing: 3) {
                    Text("기록")
                        .font(.custom("Inter-medium", size: 20))
                        .foregroundColor(selectedTab == 0 ? Color.theme.teWhite : Color.theme.teGreen)
                    
                    Rectangle()
                        .frame(maxWidth: 40, maxHeight: 3)
                        .foregroundColor(selectedTab == 0 ? Color.theme.teBlack : Color.theme.teGreen)
                    
                }
            }
            .padding(.leading, 27)
        }
        .frame(maxWidth: .infinity, maxHeight: 42, alignment: .topLeading)
        .padding(.leading, 27)
    }
    
    private func tabViewContainer() -> some View {
        TabView(selection: $selectedTab) {
            
            ScrollView {
                ringChartsContainer()
                    .padding(.bottom, 40)
                todaySummaryCountainer()
            } // end scroll view
            .tag(0)
            .scrollIndicators(.hidden)
            
            ScrollView {
                Text("아직 구현중~\n개발자가 열심히 일하고 있어요!")
                    .font(.custom("Inter-Bold", size: 24))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
                Button(action: {
                    
                    EmitterManager.shared.isEmitterOn = true
                    for i in 0 ..< 10 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / 3.0) {
                            HapticManager.shared.impact(style: .heavy, intensity: 0.97)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        EmitterManager.shared.isEmitterOn = false
                        isCongretePresented.toggle()
                    }
                    
                }) {
                    Text("Congrete Modal POPUP")
                }
                .padding(.bottom, 30)
                
                Button(action: {
                    createSampleWorkOutData()
                }) {
                    Text("어제 운동 데이터 모델 만들기")
                }
                .padding(.bottom, 30)
                
                Button(action: {
                    createTodaySampleWorkOutData()
                }) {
                    Text("오늘 운동 데이터 모델 만들기")
                }
            }
            .tag(1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.theme.teBlack)
        .cornerRadius(20)
        
        
        
        // 아래의 제스처 Modifier를 사용할 경우, 좌우 스와이프가 되지 않음.
//            .gesture(DragGesture().onChanged { value in
//                if value.translation.height < 0 {
//                    isAnimationEnabled = true
//                }
//            })
    }
    
    private func createSampleWorkOutData() {
        let coreDataManager = CoreDataManager.shared

        // 새로운 WorkOutData 객체를 생성
        guard let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData else {
            print("Failed to create WorkOutData object")
            return
        }
        
        // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
        newWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
        newWorkOutData.isBackhand = Bool.random()
        newWorkOutData.perfectSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.totalSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.workoutDate = Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
        newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
        
        // 저장
        coreDataManager.update(object: newWorkOutData)
    }
    
    private func createTodaySampleWorkOutData() {
        let coreDataManager = CoreDataManager.shared

        // 새로운 WorkOutData 객체를 생성
        guard let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData else {
            print("Failed to create WorkOutData object")
            return
        }
        
        // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
        newWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
        newWorkOutData.isBackhand = Bool.random()
        newWorkOutData.perfectSwingCount = Int16(Int.random(in: 10...100))
        newWorkOutData.totalSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.workoutDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
        newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
        
        // 저장
        coreDataManager.update(object: newWorkOutData)
    }
    
    private func ringChartsContainer() -> some View {
        let totalSwing = (workoutDataModel.todayChartDatum[6]) / Double(userDataModel.userTargetBackStroke + userDataModel.userTargetForeStroke) * 100
        let perfectStrokeRatio = workoutDataModel.todayChartDatum[7] * 100
        
        return NavigationLink(destination: TodayDetailView(workoutDataModel: workoutDataModel, userDataModel: userDataModel)) {
            VStack(spacing: 0) {
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
            .onAppear {
                print("userDataModal.userTargetForeStroke", userDataModel.userTargetForeStroke)
                print("userDataModal.userTargetBackStroke", userDataModel.userTargetBackStroke)
                print("workoutDataModel.todayChartDatum[6]", workoutDataModel.todayChartDatum[6])
                print("링차트 외부값 : ", CGFloat(workoutDataModel.todayChartDatum[6] / Double((userDataModel.userTargetBackStroke + userDataModel.userTargetForeStroke))) * 100)
            }
        }
    }
    
    private func todaySummaryCountainer() -> some View {
        VStack(spacing: 0) {
            Text("하루 요약")
                .font(.custom("Inter-Bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            summaryCountBox("오늘의 포핸드 Perfect 횟수가", "지난번보다", false)
            summaryCountBox("오늘의 백핸드 Perfect 횟수가", "지난번보다", true)
            summaryTimeBox()
        }
        .padding(.leading, 17)
        .padding(.trailing, 17)
    }
    
    private func summaryCountBox(_ firstLineString: String, _ compareString: String, _ isBackhand: Bool) -> some View {
        let todayPerfect = Int(workoutDataModel.todayChartDatum[isBackhand ? 3 : 0])
        let yesterdayPerfect = Int(workoutDataModel.todayChartDatum[isBackhand ? 4 : 1])
        let difference = Int(workoutDataModel.todayChartDatum[isBackhand ? 5 : 2])
        
        return ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 254)
                .background(Color.theme.teDarkGray)
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("\(firstLineString) \(compareString)\n\(abs(difference))회 \(difference > 0 ? "늘었습니다" : "줄었습니다").")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)
                
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 10)
                    .foregroundColor(Color.theme.teWhite)
                
                // TODO: .animation 활용 -> 스크롤이 내려가서 그 부분이 보일 때, 애니메이션이 되어서 막대그래프가 나타나도록 구현
                horizontalBarGraphContainer(todayPerfect, yesterdayPerfect, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue, false, true)
                
                horizontalBarGraphContainer(yesterdayPerfect, todayPerfect, false, false)
                    
            }
            
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
    
    private func summaryTimeBox() -> some View {
        let time = Int(workoutDataModel.todayChartDatum[10])
            
        
        return ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 254)
                .background(Color.theme.teDarkGray)
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("오늘은 지난 연습 대비 \(abs(time))분을 \(time < 0 ? "덜" : "더")\n연습했습니다.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)
                
                Rectangle()
                    .foregroundColor(Color.theme.teWhite)
                    .frame(height: 0.5)
                    .padding(.top, 10)
                
                // TODO: .animation 활용 -> 스크롤이 내려가서 그 부분이 보일 때, 애니메이션이 되어서 막대그래프가 나타나도록 구현
                horizontalBarGraphContainer(0, 0, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue, true, true, Int(workoutDataModel.todayChartDatum[8]), Int(workoutDataModel.todayChartDatum[9]))
                
                horizontalBarGraphContainer(0, 0, true, false, Int(workoutDataModel.todayChartDatum[9]), Int(workoutDataModel.todayChartDatum[8]))
                    
            }
            
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
    
    
    private func horizontalBarGraphContainer(_ swingCount: Int, _ comparisonSwing: Int, leftColor: Color = Color.theme.teWhite, rightColor: Color = Color.theme.teWhite, _ isTime: Bool = false, _ isToday: Bool = true, _ standardTime: Int = 0, _ comparisonTime: Int = 0) -> some View {
        
        let standardTimeHour = standardTime / 60
        let standardTimeMinutes = standardTime % 60
        let screenSize = UIScreen.main.bounds.width
        
        return VStack(spacing: 0) {
            HStack(spacing: 2) {
                Text("\(isTime ? standardTimeHour : swingCount)")
                    .font(.custom("Inter-SemiBold", size: 30))
                    .foregroundColor(Color.theme.teWhite)
                
                Text("\(isTime ? "시간" : "회")")
                    .font(.custom("Inter-SemiBold", size: 24))
                    .foregroundColor(Color.theme.teWhite)
                
                if isTime {
                    Text("\(standardTimeMinutes)")
                        .font(.custom("Inter-SemiBold", size: 30))
                        .foregroundColor(Color.theme.teWhite)
                        .padding(.leading, 10)
                    
                    Text("분")
                        .font(.custom("Inter-SemiBold", size: 24))
                        .foregroundColor(Color.theme.teWhite)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: sizeCalculate(CGFloat((isTime ? standardTime : swingCount)), CGFloat((isTime ? comparisonTime : comparisonSwing))), maxHeight: 23)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: leftColor, location: 0.00),
                                    Gradient.Stop(color: rightColor, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 1, y: 0.52),
                                endPoint: UnitPoint(x: -0.06, y: 0.52)
                            )
                        )
                        .cornerRadius(5)
                        .overlay(
                            Text(isToday ? "오늘" : "이전")
                                .foregroundColor(.black)
                                .font(.custom("Inter-SemiBold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 16)
                                
                        )
                        .scaleEffect(x: isAnimationEnabled ? 1 : 0, y: 1, anchor: .leading)
                        .animation(.easeOut(duration: 2), value: isAnimationEnabled)
                        .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.top, 10)
        
        
        func sizeCalculate(_ A: CGFloat, _ B: CGFloat) -> CGFloat {
            return CGFloat(A / B * screenSize)
            
        }
        
        func findGCD(_ num1: CGFloat, _ num2: CGFloat) -> CGFloat {
            var x = 0
            var y: Int = Int(max(num1, num2))
            var z: Int = Int(min(num1, num2))
            
            while z != 0 {
                x = y
                y = z
                z = x % y
            }
            return CGFloat(y)
        }
    }
    
}

struct MainView_Provider: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}
