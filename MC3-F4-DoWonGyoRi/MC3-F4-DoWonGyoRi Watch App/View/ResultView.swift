//
//  ResultView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI

struct ResultView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("여기 폭죽 터지고 난리내기")
                }
                .tabItem{
                    Image(systemName: "tennisball.fill")
                        .foregroundColor(Color.watchColor.lightGreen)
                }
                .tag(0)
                
                VStack {
                    SwingRateView()
                }
                .tabItem{
                    Image(systemName: "tennisball.fill")
                        .foregroundColor(Color.watchColor.lightGreen)
                }
                .tag(1)
                
                VStack {
                    Text("운동 요약")
                    NavigationLink(destination: CompleteView()) {
                        Text("완료 버튼")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.black)
                    }
                }
                .tabItem{
                    Image(systemName: "tennisball.fill")
                        .foregroundColor(Color.watchColor.lightGreen)
                }
                .tag(2)
            }
            .onAppear {
                selectedTab = 1
            }
        }
        .navigationTitle("요약")
        .navigationBarBackButtonHidden()
    }
}

struct SwingRateView: View {
    @State var progressValue: Float = 0.0
    @State var perfectCount: Int = 30
    @State var badCount: Int = 30
    @State var fontSize: CGFloat = 20.0

    var body: some View {
        VStack {
            Spacer()
            ResultCircleProgressBar(progress: self.$progressValue, perfectCount: self.$perfectCount, badCount: self.$badCount, fontSize: self.$fontSize)
                .frame(width: 150, height: 150, alignment: .center)
        }
        .onAppear {
            perfectRate()
        }
    }
    
    private func perfectRate() {
        progressValue = Float(perfectCount) / Float((perfectCount + badCount))
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
