//
//  CircleProgressBar.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/12.
//

import SwiftUI

struct CircleProgressBar: View {
    @Binding var progress: Float
    @Binding var count: String
    @Binding var fontSize: CGFloat
    var gradientColors: [Color] = [Color.watchColor.lightGreen, Color.watchColor.lightBlue]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0))

            Text(self.count)
                .font(.system(size: self.fontSize, weight: .bold))
        }
    }
}


//MARK: - 확인용

struct ContentView: View {
    @State var progressValue: Float = 0.0
    @State var countValue: String = ""
    @State var counting: Int = 0
    @State var fontSize: CGFloat = 48.0
    let readyStatus = ["준비", "3", "2", "1", "시작!"]
    

    var body: some View {
        VStack {
            CircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: $fontSize)
                .frame(width: 180, height: 180, alignment: .center)
                .onAppear {
                    startProgressAnimation()
                }
        }
    }

    func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.progressValue += 0.3
                self.counting += 1
            }
            if self.progressValue >= 1.0 {
                self.countValue = readyStatus[counting]
                
            } else {
                self.countValue = readyStatus[counting]
                self.startProgressAnimation()
            }
        }
    }
}


struct CircleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
