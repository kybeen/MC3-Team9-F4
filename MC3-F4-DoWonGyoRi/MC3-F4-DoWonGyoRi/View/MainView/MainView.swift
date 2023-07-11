//
//  MainView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI
import Charts

let title1 = "정의로운"
let title2 = "테니스왕자"
let nickname = "김배찌"
let suffix = "님"
let totalSwing = 500
let totalYesterdaySwing = 300
let totalBackhandPerfectCount = yesterdayBackhandPerfectCount + todayBackhandPerfectCount
let totalForehandPerfectCount = yesterdayForehandPerfectCount + todayForehandPerfectCount
let yesterdayForehandPerfectCount = 200
let todayForehandPerfectCount = 200
let yesterdayBackhandPerfectCount = 300
let todayBackhandPerfectCount = 100

let todayPerfectCount = 100
let perfectDifference = todayPerfectCount - yesterdayForehandPerfectCount

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            containerView()
            namespaceContainer()
            
            VStack(spacing: 0) {
                tabsContainer()
                
                GeometryReader { geometry in
                    TabView(selection: $selectedTab) {
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                ZStack {
                                    Circle()
                                        .frame(maxWidth: geometry.size.width - 46, maxHeight: geometry.size.width - 46)
                                        .foregroundColor(.black)
                                    VStack {
                                        RingChartsView(values: [220, 20], colors: [[.gray, .green], [.gray, .blue]], ringsMaxValue: 100, lineWidth: 25, isAnimated: true)
                                        
                                            .frame(width: geometry.size.width - 90, height: geometry.size.width - 90, alignment: .center)
                                    }
                                    VStack(spacing: 0) {
                                        Text("Perfect")
                                            .font(.custom("Inter-Bold", size: 24))
                                        
                                            .padding(.bottom, 12)
                                            .foregroundColor(.blue)
                                        Text("\(todayPerfectCount)회")
                                            .font(.custom("Inter-Bold", size: 30))
                                    }
                                }
                                
                            }
                            .frame(maxWidth: geometry.size.width, minHeight: geometry.size.width)
                            
                            
                            /**
                             하루 요약
                             */
                            VStack(spacing: 0) {
                                Text("하루 요약")
                                    .font(.custom("Inter-Bold", size: 24))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(maxWidth: .infinity, minHeight: 254)
                                        .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                        .cornerRadius(13)
                                        .padding(.top, 14)
                                    VStack(spacing: 0) {
                                        Text("오늘의 포핸드 Perfect 횟수가 지난번보다\n\(abs(perfectDifference))회 \(perfectDifference > 0 ? "늘었습니다" : "줄었습니다").")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .frame(height: 0.5)
                                            .padding(.top, 10)
                                        
                                        // TODO: .animation 활용 -> 스크롤이 내려가서 그 부분이 보일 때, 애니메이션이 되어서 막대그래프가 나타나도록 구현
                                        HStack(spacing: 2) {
                                            Text("\("100")")
                                                .font(.custom("Inter-SemiBold", size: 30))
                                            
                                            Text("회")
                                                .font(.custom("Inter-SemiBold", size: 24))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 10)
                                        VStack {
                                            Rectangle()
                                                .frame(width: geometry.size.width, height: 23)
                                                .padding(.top, 10)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    .frame(alignment: .leading)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: .infinity, height: 254)
                                        .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                        .cornerRadius(13)
                                        .padding(.top, 14)
                                    VStack(spacing: 0) {
                                        Text("오늘의 백핸드 Perfect 횟수가 지난번보다\n\(abs(perfectDifference))회 \(perfectDifference > 0 ? "늘었습니다" : "줄었습니다").")
                                        
                                    }
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: .infinity, height: 254)
                                        .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                        .cornerRadius(13)
                                        .padding(.top, 14)
                                    VStack(spacing: 0) {
                                        Text("오늘의 포핸드 Perfect 횟수가 지난번보다\n\(abs(perfectDifference))회 \(perfectDifference > 0 ? "늘었습니다" : "줄었습니다").")
                                    }
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: .infinity, height: 254)
                                        .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                        .cornerRadius(13)
                                        .padding(.top, 14)
                                    VStack(spacing: 0) {
                                        Text("오늘의 포핸드 Perfect 횟수가 지난번보다\n\(abs(perfectDifference))회 \(perfectDifference > 0 ? "늘었습니다" : "줄었습니다").")
                                    }
                                }
                                
                            }
                            .padding(.leading, 17)
                            .padding(.trailing, 17)
                            
                            
                        } // end scroll view
                        .border(.red)
                        .background(.brown)
                        
                        
                        .tag(0)
                        
                        ScrollView {
                            ForEach(0 ..< 50) { _ in
                                Text("기록")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.bottom, 50)
                        }
                        .tag(1)
                    } // end geometryreader
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

extension MainView {
    private func containerView() -> some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "figure.strengthtraining.functional")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 27)
            }
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 27)
                
            }
        }
    }
    
    private func namespaceContainer() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("어서오세요")
                .font(.custom("Inter-SemiBold", size: 28))
                .padding(.bottom, 2)
            Text(title1 + " " + title2 + " " + nickname + suffix)
                .font(.custom("Inter-SemiBold", size: 28))
            //                NameSpaceText()
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
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
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    
                    
                    Rectangle()
                        .frame(maxWidth: 118, maxHeight: 3)
                        .foregroundColor(selectedTab == 0 ? .blue : .black)
                    
                }
                .frame(maxWidth: 100)
            }
            Button(action: {
                selectedTab = 1
            }) {
                VStack(spacing: 3) {
                    Text("기록")
                        .font(.custom("Inter-medium", size: 20))
                        .foregroundColor(selectedTab == 0 ? .gray : .blue)
                    
                    Rectangle()
                        .frame(maxWidth: 40, maxHeight: 3)
                        .foregroundColor(selectedTab == 0 ? .black : .blue)
                    
                }
            }
            .padding(.leading, 27)
        }
        .frame(maxWidth: .infinity, maxHeight: 42, alignment: .topLeading)
        .padding(.leading, 27)
    }
    
    
    private func scrollContainer() -> some View {
        
        ScrollView {
            ForEach(0 ..< 100) {_ in
                Text("안녕")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
    
    
}


struct MainView_Provider: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}

struct MeasureSizeModifier: ViewModifier {
    let callback: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            callback(proxy.size)
                        }
                }
            }
    }
}
