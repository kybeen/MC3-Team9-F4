//
//  ReadyView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct ReadyView: View {
    @State private var progressValue: Float = 0.0
    @State private var countValue: String = ""
    @State var counting: Int = 0
    @State private var fontSize: CGFloat = 48.0
    let readyStatus = ["준비", "3", "2", "1", "시작!"]
    @State private var isCountingViewPresented: Bool = false


    var body: some View {
        VStack {
            TimeCircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: self.$fontSize)
                .frame(width: 150, height: 150, alignment: .center)
                .onAppear {
                    //초기화
                    progressValue = 0.0
                    counting = 0
                    startProgressAnimation()
                }
        }
        .background(
            NavigationLink(destination: CountingView(),
                           isActive: $isCountingViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .navigationBarBackButtonHidden()
    }

    private func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.progressValue += 0.33
                self.counting += 1
            }
            if self.progressValue >= 1.0 {
                self.countValue = readyStatus[counting]
                if self.countValue == "시작!" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isCountingViewPresented = true
                    }
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
