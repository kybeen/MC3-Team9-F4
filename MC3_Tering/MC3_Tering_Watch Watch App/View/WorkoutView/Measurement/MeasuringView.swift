//
//  MeasuringView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

//MARK: - "측정 중..." 애니메이션 화면
struct MeasuringView: View {
    @State private var isSwingResultViewPresented = false
    @State private var measuringString:String = ""
    @State private var bounceHeight: BounceHeight? = nil
    
    @EnvironmentObject var swingInfo: SwingInfo
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    func bounceAnimation() {
        
        withAnimation(Animation.easeOut(duration: 0.3).delay(0.5)) {
            bounceHeight = .up60
        }
        withAnimation(Animation.easeInOut(duration: 0.04).delay(0.5)) {
            bounceHeight = .up60
        }
        withAnimation(Animation.easeIn(duration: 0.3).delay(0.84)) {
            bounceHeight = .base
            measuringString += "."
        }
        withAnimation(Animation.easeOut(duration: 0.2).delay(1.14)) {
            bounceHeight = .up30
        }
        withAnimation(Animation.easeIn(duration: 0.2).delay(1.34)) {
            bounceHeight = .base
            measuringString += "."
        }
        withAnimation(Animation.easeOut(duration: 0.1).delay(1.54)) {
            bounceHeight = .up10
        }
        withAnimation(Animation.easeIn(duration: 0.1).delay(1.64)) {
            bounceHeight = .none
            measuringString += "."
        }
    }
    
    var body: some View {
        
        
        ZStack {
            Image("tennisBall")
                .resizable()
                .frame(width: 44, height: 44)
                .shadow(radius: 3)
                .offset(y: bounceHeight?.associatedOffset ?? 0)
            
            ZStack {
                Text("측정 중")
                    .font(.system(size: 24, weight: .semibold))
                HStack {
                    Text(measuringString)
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.leading, 72)
                }
            }
            .padding(.top, 100)
        }
        
        .onAppear {
            WKInterfaceDevice.current().play(.notification)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                bounceAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isSwingResultViewPresented = true
                tennisClassifierViewModel.pauseMotionTracking() // 측정 중에는 device motion 추적 일시중지
            }
        }
        .background(
            NavigationLink(destination: SwingResultView(resultColor: Color.clear), isActive: $isSwingResultViewPresented) {
                EmptyView()
            }
                .hidden()
        )
        .navigationBarBackButtonHidden()
    }
}

enum BounceHeight {
    case up60, up30, up10, base
    var associatedOffset: Double {
        switch self {
        case .up60:
            return -60
        case .up30:
            return -30
        case .up10:
            return -10
        case .base:
            return 0
        }
    }
}







struct MeasuringView_Previews: PreviewProvider {
    
    static var previews: some View {
        MeasuringView()
            .environmentObject(SwingInfo())
    }
}
