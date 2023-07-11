//
//  MainView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI

let title1 = "정의로운"
let title2 = "테니스왕자"
let nickname = "김배찌"
let suffix = "님"
let todayPerfectCount = 100
struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            containerView()
            namespaceContainer()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
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
                
                TabView(selection: $selectedTab) {
                    GeometryReader { geometry in
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
                                            .font(.custom("Inter-", size: <#T##CGFloat#>))
                                        Text("\(todayPerfectCount)회")
                                            .font(.custom())
                                    }
                                }
                                
                            }
                            .frame(maxWidth: geometry.size.width, minHeight: geometry.size.width)
                        }
                        
                        
                    }
                    .tag(0)
                    
                    ScrollView {
                        ForEach(0 ..< 50) { _ in
                            Text("기록")
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 50)
                    }
                    .tag(1)
                    
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
