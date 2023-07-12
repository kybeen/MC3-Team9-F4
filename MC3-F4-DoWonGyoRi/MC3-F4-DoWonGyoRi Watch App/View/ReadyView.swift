//
//  ReadyView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/11.
//

import SwiftUI

struct ReadyView: View {
    @State var progressValue: Float = 0.0
    @State var countValue: String = ""
    @State var counting: Int = 0
    let readyStatus = ["준비", "3", "2", "1", "시작!"]
    @State var isCountingViewPresented: Bool = false


    var body: some View {
        VStack {
            CircleProgressBar(progress: self.$progressValue, count: self.$countValue)
                .frame(width: 150, height: 150, alignment: .center)
                .onAppear {
                    startProgressAnimation()
                }
        }
        .navigationBarBackButtonHidden()
        .background(
            NavigationLink(destination: CountingView(), isActive: $isCountingViewPresented) {
                EmptyView()
            }
            .hidden()
        )
    }

    func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.progressValue += 0.33
                self.counting += 1
            }
            if self.progressValue >= 1.0 {
                self.countValue = readyStatus[counting]
                if self.countValue == "시작!" {
                    self.isCountingViewPresented = true
                    return
                }
                
            } else {
                self.countValue = readyStatus[counting]
                self.startProgressAnimation()
            }
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView()
    }
}
