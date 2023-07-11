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

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            containerView()
            namespaceContainer()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Text("오늘의 스윙")
                            .font(.custom("Inter-medium", size: 20))
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    }
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Text("기록")
                            .font(.custom("Inter-medium", size: 20))
                            .foregroundColor(selectedTab == 0 ? .gray : .blue)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 42, alignment: .topLeading)
                
                
                TabView(selection: $selectedTab) {
                    GeometryReader { geometry in
                        ScrollView {
                            ForEach(0 ..< 50) { _ in
                                Text("안녕")
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                        .background(.purple)
                        .cornerRadius(20)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    }
                    .tag(0)
                    
                    GeometryReader { geometry in
                        ScrollView {
                            ForEach(0 ..< 50) { _ in
                                Text("안녕")
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                        .background(.purple)
                        .cornerRadius(20)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    }
                    .tag(1)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
//            .frame(maxHeight: .infinity)
        }
        
        .frame(maxHeight: .infinity, alignment: .top)
        //        }
        
        
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
        GeometryReader { geometry in
            ScrollView {
                ForEach(0 ..< 100) {_ in
                    Text("안녕")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
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

extension View {
    func measureSize(_ callback: @escaping (CGSize) -> Void) -> some View {
        modifier(MeasureSizeModifier(callback: callback))
    }
    
    func frameSize(width: CGFloat, height: CGFloat) -> some View {
        self.frame(
            width: convertToCGFloat(point: width, isWidth: true) * UIScreen.main.bounds.width,
            height: convertToCGFloat(point: height, isWidth: false) * UIScreen.main.bounds.height
        )
    }
    
    func convertToCGFloat(point: CGFloat, isWidth: Bool) -> CGFloat {
        let baseSize = isWidth ? 393.0 : 852.0
        
        return point / baseSize
    }
    
    
}
