//
//  MainView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI
import Charts

struct MainView: View {
    @ObservedObject var userDataModel: UserDataModel
    @ObservedObject var workoutDataModel: WorkOutDataModel
    @State private var selectedTab = 0
    @State var isAnimationEnabled = false
    @State var isGuidePresent = false
    @State private var path: [Int] = []
    @State private var isCongretePresented = false
    @AppStorage("_isFirstGuide") var isFirstGuide: Bool = true
    @State var modalTitle1 = ""
    @State var modalTitle2 = ""
    @State var modalAttainment = ""
    @State var modalGainTitle = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            // ZStack 으로 처리
            VStack(spacing: 0) {
                containerView()
                namespaceContainer()
                
                VStack(spacing: 0) {
                    tabsContainer()
                    tabViewContainer()
                }
                .padding(.top, 20)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                userDataModel.fetchUserData()
                workoutDataModel.fetchWorkOutData()
                workoutDataModel.fetchTodayAndYesterdayWorkout()
            }
            .onDisappear {
                userDataModel.saveUserData()
                workoutDataModel.saveWorkOutData()
            }
            
        }
        .sheet(isPresented: $isCongretePresented, content: {
            CongreteModalView(title1: modalTitle1, title2: modalTitle2, attainment: modalAttainment, gainTitle: modalGainTitle)
                .presentationDetents([.fraction(0.7), .fraction(0.7)])
        })
        .fullScreenCover(isPresented: $isFirstGuide, content: {
            ZStack {
                Color.theme.teBlack.opacity(0.1).edgesIgnoringSafeArea(.all)
                BackgroundBlurView().edgesIgnoringSafeArea(.all)
                AppGuideView(isFirstGuide: $isFirstGuide)
            }
        })
    }
        
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
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
            NavigationLink(destination: SettingView(userDataModel: userDataModel)) {
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
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(userDataModel.userTitle1)
                    .font(.custom("Inter-SemiBold", size: 28))
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.trailing, 10)
                Text(userDataModel.userTitle2)
                    .font(.custom("Inter-SemiBold", size: 28))
                    .foregroundColor(Color.theme.teSkyBlue)
            }
            Text(userDataModel.username + "님")
                .font(.custom("Inter-Bold", size: 28))
                .foregroundColor(Color.theme.teWhite)
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
                    .padding(.bottom, 30)
                todaySummaryCountainer()
            } // end scroll view
            .tag(0)
            .scrollIndicators(.hidden)
            
            ScrollView {
                RecordListView()
                    .padding(.top, 2)
                    .padding(.horizontal, 16)
            }
            .tag(1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.theme.teBlack)
        .cornerRadius(20)
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
                        Text("SWING")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color.theme.teGreen)
                        Text("\(Int(workoutDataModel.todayChartDatum[6]))/\(userDataModel.userTargetBackStroke + userDataModel.userTargetForeStroke)")
                            .font(.custom("Inter-Bold", size: 28))
                            .foregroundColor(Color.theme.teWhite)
                            .padding(.bottom, 14)
                        Text("PERFECT")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color.theme.teSkyBlue)
                        Text("\(Int(workoutDataModel.todayChartDatum[6] * workoutDataModel.todayChartDatum[7]))/\(Int(workoutDataModel.todayChartDatum[6]))")
                            .font(.custom("Inter-Bold", size: 28))
                            .foregroundColor(Color.theme.teWhite)
                    }
                }
                .padding(.top, 40)
                .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.width)
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
        .padding(.top, 10)
        
        
        func sizeCalculate(_ A: CGFloat, _ B: CGFloat) -> CGFloat {
            if A == 0 || B == 0 {
                return CGFloat(45)
            }
            print("막대그래프 길이 : ",CGFloat(A / B * screenSize) < 60 ? 60 : CGFloat(A / B * screenSize))
            return CGFloat(A / B * screenSize) < 45 ? 45 : CGFloat(A / B * screenSize)
            
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
    
    private func addUserCountData() {
        let a = Int.random(in: 200...500)
        let c = Int.random(in: 10...200)
        let d = Int.random(in: 10...50)
        let e = Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
        let f = Int.random(in: 10...200)
        
        workoutDataModel.createSampleWorkOutData(a, f, c, d, c, c + c, e)
        userDataModel.totalSwingCount += Int(c)
        userDataModel.totalPerfectCount += Int(d)
        userDataModel.userPerfectRatio = Double(userDataModel.totalPerfectCount) / Double(userDataModel.totalSwingCount)
        userDataModel.saveUserData()
    }
    
    private func modifyModalContent(_ modalTitle1: String, _ modalTitle2: String, _ modalAttainMent: String, _ modalGainTitle: String, _ isTitle1: Bool) {
        if isTitle1 {
            userDataModel.userTitle1List.append(modalGainTitle)
        } else {
            userDataModel.userTitle2List.append(modalGainTitle)
        }
        
        self.modalTitle1 = "\(modalTitle1) "
        self.modalTitle2 = modalTitle2
        self.modalAttainment = "\(modalAttainMent) "
        self.modalGainTitle = modalGainTitle
    }
    
    private func emmiterOn() {
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
    }
    
    private func checkTitle1Gain() {
        switch userDataModel.totalSwingCount {
        case 200 ..< 500:
            if !userDataModel.userTitle1List.contains("가능성이 보이는") {
                modifyModalContent("Swing ", "전체 횟수", "200회 ", "가능성이 보이는", true)
                emmiterOn()
                userDataModel.userTitle1 = "가능성이 보이는"
            }
        case 500 ..< 1000:
            if !userDataModel.userTitle1List.contains("쉬지 않는") {
                modifyModalContent("Swing ", "전체 횟수", "500회 ", "쉬지 않는", true)
                emmiterOn()
                userDataModel.userTitle1 = "쉬지 않는"
            }
        case 1000 ..< 2000:
            if !userDataModel.userTitle1List.contains("뚝심있는") {
                modifyModalContent("Swing ", "전체 횟수", "1000회 ", "뚝심있는", true)
                emmiterOn()
                userDataModel.userTitle1 = "뚝심있는"
            }
        case 2000 ..< 3000:
            if !userDataModel.userTitle1List.contains("기풍있는") {
                modifyModalContent("Swing ", "전체 횟수", "2000회 ", "기풍있는", true)
                emmiterOn()
                userDataModel.userTitle1 = "기풍있는"
            }
        case 3000 ..< 4000:
            if !userDataModel.userTitle1List.contains("지는 법을 모르는") {
                modifyModalContent("Swing ", "전체 횟수", "3000회 ", "지는 법을 모르는", true)
                emmiterOn()
                userDataModel.userTitle1 = "지는 법을 모르는"
            }
        case 4000 ..< 5000:
            if !userDataModel.userTitle1List.contains("막을 수 없는") {
                modifyModalContent("Swing ", "전체 횟수", "4000회 ", "막을 수 없는", true)
                emmiterOn()
                userDataModel.userTitle1 = "막을 수 없는"
            }
        case 5000 ..< 7500:
            if !userDataModel.userTitle1List.contains("전설의 출현") {
                modifyModalContent("Swing ", "전체 횟수", "5000회 ", "전설의 출현", true)
                emmiterOn()
                userDataModel.userTitle1 = "전설의 출현"
            }
        case 7500 ..< 10000:
            if !userDataModel.userTitle1List.contains("우주 유일의") {
                modifyModalContent("Swing ", "전체 횟수", "10000회 ", "우주 유일의", true)
                emmiterOn()
                userDataModel.userTitle1 = "우주 유일의"
            }
        default:
            print("defalut")
        }
        userDataModel.saveUserData()
    }
    
    private func checkTitle2Gain() {
        // usertitle2 관련
        switch userDataModel.totalPerfectCount {
            case 200 ..< 400:
                if !userDataModel.userTitle2List.contains("테린이") {
                    modifyModalContent("Perfect ", "횟수", "200회 ", "테린이", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "테린이"
                }
            case 400 ..< 600:
                if !userDataModel.userTitle2List.contains("아마추어") {
                    modifyModalContent("Perfect ", "횟수", "400회 ", "아마추어", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "아마추어"
                }
            case 600 ..< 800:
                if !userDataModel.userTitle2List.contains("생활체육인") {
                    modifyModalContent("Perfect ", "횟수", "600회 ", "생활체육인", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "생활체육인"
                }
            
        case 800 ..< 1000:
                if !userDataModel.userTitle2List.contains("슈퍼루키") {
                    modifyModalContent("Perfect ", "횟수", "800회 ", "슈퍼루키", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "슈퍼루키"
                }
            case 1000 ..< 2000:
                if !userDataModel.userTitle2List.contains("테니스석사") {
                    modifyModalContent("Perfect ", "횟수", "1000회 ", "테니스석사", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "테니스석사"
                }
            case 2000 ..< 3500:
                if !userDataModel.userTitle2List.contains("테니스박사") {
                    modifyModalContent("Perfect ", "횟수", "2000회 ", "테니스박사", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "테니스박사"
                }
            case 3500 ..< 5000:
                if !userDataModel.userTitle2List.contains("테니스황제") {
                    modifyModalContent("Perfect ", "횟수", "3500회 ", "테니스황제", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "테니스황제"
                }
            case 5000 ..< 7500:
                if !userDataModel.userTitle2List.contains("월드클래스") {
                    modifyModalContent("Perfect ", "횟수", "5000회 ", "월드클래스", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "월드클래스"
                }
        case 7500 ..< 10000 :
                if !userDataModel.userTitle2List.contains("최고존엄") {
                    modifyModalContent("Perfect ", "횟수", "5000회 ", "최고존엄", false)
                    emmiterOn()
                    userDataModel.userTitle2 = "최고존엄"
                }
        default:
            print("defalut")
        }
        userDataModel.saveUserData()
        print("userDataModel.totalSwingCount : ", userDataModel.totalSwingCount)
        print("userDataModel.totalPerfectCount : ", userDataModel.totalPerfectCount)
        print("userDataModel.userPerfectRatio : ", userDataModel.userPerfectRatio)
    }
}

struct MainView_Provider: PreviewProvider {
    @ObservedObject static var userDataModel = UserDataModel.shared
    @ObservedObject static var workoutDataModel = WorkOutDataModel.shared
    
    static var previews: some View {
        MainView(userDataModel: userDataModel, workoutDataModel: workoutDataModel).preferredColorScheme(.dark)
    }
}
