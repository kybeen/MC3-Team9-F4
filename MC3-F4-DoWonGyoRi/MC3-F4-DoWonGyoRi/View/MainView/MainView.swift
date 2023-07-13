//
//  MainView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI
import Charts

let title1 = "고독한"
let title2 = "승부사"
let nickname = "장필우"
let suffix = "님"
let totalSwing = 500
let totalYesterdaySwing = 300
let totalBackhandPerfectCount = yesterdayBackhandPerfectCount + todayBackhandPerfectCount
let totalForehandPerfectCount = yesterdayForehandPerfectCount + todayForehandPerfectCount
let yesterdayForehandPerfectCount = 100
let todayForehandPerfectCount = 200
let yesterdayBackhandPerfectCount = 300
let todayBackhandPerfectCount = 100
let todayPlayTime = 120
let lastPlayTime = 60
let todayPerfectCount = 100
let perfectDifference = 30

struct MainView: View {
    @State private var selectedTab = 0
    @State var isAnimationEnabled = false
    @State private var path: [Int] = []
    
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isAnimationEnabled = true
                }
            }
        }
    }
}


extension MainView {
    private func containerView() -> some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "figure.tennis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.theme.teGreen)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 27)
            }
            Spacer()
//            NavigationLink(destination: SettingView(path: $path, count: int)) { int in
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(Color.theme.teWhite)
//                    .frame(width: 35, height: 35)
//                    .padding(.trailing, 27)
//            }
            Button(action: {
                path.append(0)
            }) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.theme.teWhite)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 27)
            }
            .navigationDestination(for: Int.self) { int in
                SettingView(path: $path, count: int)
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
                Text(title1)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.trailing, 10)
                Text(title2)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teSkyBlue)
                    .padding(.trailing, 10)
                Text(nickname + suffix)
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
            
            // 아래의 제스처 Modifier를 사용할 경우, 좌우 스와이프가 되지 않음.
//            .gesture(DragGesture().onChanged { value in
//                if value.translation.height < 0 {
//                    isAnimationEnabled = true
//                }
//            })
            .tag(0)
            ScrollView {
            }
            .tag(1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.theme.teBlack)
        .cornerRadius(20)
    }
    
    private func scrollContainer() -> some View {
        
        ScrollView {
            ForEach(0 ..< 100) {_ in
                Text("안녕")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
    
    
    private func ringChartsContainer() -> some View {
        
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
    
    private func todaySummaryCountainer() -> some View {
        VStack(spacing: 0) {
            Text("하루 요약")
                .font(.custom("Inter-Bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            summaryCountBox("오늘의 포핸드 Perfect 횟수가", "지난번보다")
            summaryCountBox("오늘의 백핸드 Perfect 횟수가", "지난번보다")
            summaryTimeBox()
        }
        .padding(.leading, 17)
        .padding(.trailing, 17)
    }
    
    private func summaryCountBox(_ firstLineString: String, _ compareString: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 254)
                .background(Color.theme.teDarkGray)
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("\(firstLineString) \(compareString)\n\(abs(perfectDifference))회 \(perfectDifference > 0 ? "늘었습니다" : "줄었습니다").")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)
                
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 10)
                    .foregroundColor(Color.theme.teWhite)
                
                // TODO: .animation 활용 -> 스크롤이 내려가서 그 부분이 보일 때, 애니메이션이 되어서 막대그래프가 나타나도록 구현
                horizontalBarGraphContainer(1500, 2000, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue)
                
                horizontalBarGraphContainer(500, 2000)
                    
            }
            
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
    
    private func summaryTimeBox() -> some View {
        let time = todayPlayTime - lastPlayTime
        
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
                horizontalBarGraphContainer(0, 0, leftColor: Color.theme.teGreen, rightColor: Color.theme.teSkyBlue, true, 1600, 12000)
                
                horizontalBarGraphContainer(0, 0, true, 12000, 1600)
                    
            }
            
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
    
    
    private func horizontalBarGraphContainer(_ swingCount: Int, _ totalSwing: Int, leftColor: Color = Color.theme.teWhite, rightColor: Color = Color.theme.teWhite, _ isTime: Bool = false, _ standardTime: Int = 0, _ comparisonTime: Int = 0) -> some View {
        
        let standardTimeHour = standardTime / 60
        let standardTimeMinutes = standardTime % 60
        
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
                        .frame(maxWidth: sizeCalculate(isTime ? CGFloat(abs(standardTime + comparisonTime)) : CGFloat(abs(totalSwing - swingCount)), isTime ? CGFloat(standardTime) : CGFloat(totalSwing)), maxHeight: 23)
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
                            Text("오늘")
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
            
            return CGFloat(isTime ? B / A * 400 : B / A * 100)
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
