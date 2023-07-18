//
//  ResultView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI
import CoreMotion
import WatchKit
import SpriteKit


struct ResultView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                VStack {
                    ResultEffectView()
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
                    HealthKitView()
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

//MARK: - Tag(0) : 기울임에 따라 움직이기 성공

//struct ResultEffectView: View {
//    @State private var offsets: [CGSize] = []
//    @State private var perfectCount: Int = 3
//
//    private let motionManager = CMMotionManager()
//
//    var body: some View {
//        ZStack {
//            ForEach(offsets.indices, id: \.self) { index in
//                Image("tennisBall")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .padding()
//                    .offset(x: validOffset(at: index).width, y: validOffset(at: index).height)
//                    .animation(.easeOut(duration: 0.5))
//            }
//        }
//        .onAppear {
//            initializeOffsets()
//            startMotionUpdates()
//        }
//        .onDisappear {
//            stopMotionUpdates()
//        }
//    }
//
//    private func initializeOffsets() {
//        offsets = Array(repeating: .zero, count: perfectCount)
//    }
//
//    private func validOffset(at index: Int) -> CGSize {
//        guard index >= 0 && index < offsets.count else {
//            return .zero
//        }
//        return offsets[index]
//    }
//
//    private func startMotionUpdates() {
//        guard motionManager.isDeviceMotionAvailable else { return }
//
//        motionManager.deviceMotionUpdateInterval = 0.2
//        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
//            guard let motion = motion else { return }
//
//            let pitch = motion.attitude.pitch
//            let roll = motion.attitude.roll
//
//            DispatchQueue.main.async {
//                self.updateOffsets(pitch: pitch, roll: roll)
//            }
//        }
//    }
//
//
//    private func updateOffsets(pitch: Double, roll: Double) {
//        offsets.indices.forEach { index in
//            let randomOffset = CGSize(width: CGFloat.random(in: -50...50), height: CGFloat.random(in: -50...50))
//            offsets[index] = CGSize(width: CGFloat(roll) * 100 + randomOffset.width, height: CGFloat(pitch) * 100 + randomOffset.height)
//        }
//    }
//
//    private func stopMotionUpdates() {
//        motionManager.stopDeviceMotionUpdates()
//    }
//}

//MARK: - 기본 폭죽 (움직이기 없이)
//struct ResultEffectView: View {
//
//
//    @State private var isLiked: [Bool] = [false, false, false]
//
//    var body: some View {
//        VStack {
//            HStack(spacing: 20) {
//                CustomButton(systemImage: "tennisBall", status: isLiked[0], activeTint: .pink, inActiveTint: .gray) {
//                    isLiked[0].toggle()
//                }
//                CustomButton(systemImage: "tennisBall", status: isLiked[1], activeTint: .pink, inActiveTint: .gray) {
//                    isLiked[1].toggle()
//                }
//                CustomButton(systemImage: "tennisBall", status: isLiked[2], activeTint: .pink, inActiveTint: .gray) {
//                    isLiked[2].toggle()
//                }
//            }
//        }
//    }
//
//
//    @ViewBuilder
//    func CustomButton(systemImage: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View {
//        Button(action: onTap) {
//            Image(systemImage)
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(status ? activeTint : inActiveTint)
//                .particleEffect(systemImage: systemImage, font: .title2, status: status, activeTint: activeTint, inActiveTint: inActiveTint)
//                .padding(.horizontal, 18)
//                .padding(.vertical, 8)
//        }
//    }
//}




//MARK: - Tag(1)
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

//MARK: - Tag(2)
struct HealthKitView: View {
    @EnvironmentObject var swingListWrapper: SwingListWrapper

    //우선 타입 임의로 지정
    @State var workingMin: String = "00:00.00"
    @State var bpm: Int = 150
    @State var kcal: Int = 160
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(workingMin)
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(Color.watchColor.lightGreen)
                .padding(.bottom, 2)
            
            Text("\(bpm) BPM")
                .font(.system(size: 20, weight: .medium))

            Text("\(kcal) kcal")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 8)
            
            Spacer()
            NavigationLink(destination: SwingListView(swingList: swingListWrapper.swingList)) {
                Text("완료")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.black)
            }
            
//            Button(action: {
//                print("clicked")
//            }) {
//                Text("완료")
//                    .font(.system(size: 20, weight: .bold))
//            }
            
            .foregroundColor(Color.watchColor.black) // 2
            .background(Color.watchColor.lightGreen) // 3
            .cornerRadius(20)

            
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultEffectView()
    }
}




//MARK: - 일단 파티클이 되는거긴한데, 하나 누르면 다 같이 눌리는 파티클

struct ResultEffectView: View {

    @State private var offsets: [CGSize] = []
    @State private var perfectCount: Int = 3
    @State private var isLiked: [Bool] = []

    private let motionManager = CMMotionManager()

    var body: some View {
        ZStack {
            ForEach(offsets.indices, id: \.self) { index in
                CustomButton(systemImage: "tennisBall", status: isLiked[index], activeTint: .pink, inActiveTint: .gray) {
                    isLiked[index].toggle()
                }
                .offset(x: validOffset(at: index).width, y: validOffset(at: index).height)
                .animation(.easeOut(duration: 0.5))
            }
        }
        .onAppear {
            initializeOffsets()
            startMotionUpdates()
            isLiked = Array(repeating: false, count: perfectCount)
        }
        .onDisappear {
            stopMotionUpdates()
        }
    }


//    @ViewBuilder
//    func CustomButton(systemImage: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View {
//        Button(action: onTap) {
//            Image(systemImage)
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(status ? activeTint : inActiveTint)
//                .particleEffect(systemImage: systemImage, font: .title2, status: status, activeTint: activeTint, inActiveTint: inActiveTint)
//                .padding(.horizontal, 18)
//                .padding(.vertical, 8)
//        }
//    }
    
    func CustomButton(systemImage: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View {
        Image("tennisBall")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(status ? activeTint : inActiveTint)
            .particleEffect(systemImage: systemImage, font: .title2, status: status, activeTint: activeTint, inActiveTint: inActiveTint)
            .padding(.horizontal, 18)
            .padding(.vertical, 8)
            .onTapGesture(perform: onTap)
    }


    private func initializeOffsets() {
        offsets = Array(repeating: .zero, count: perfectCount)
    }

    private func validOffset(at index: Int) -> CGSize {
        guard index >= 0 && index < offsets.count else {
            return .zero
        }
        return offsets[index]
    }

    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }

        motionManager.deviceMotionUpdateInterval = 0.2
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
            guard let motion = motion else { return }

            let pitch = motion.attitude.pitch
            let roll = motion.attitude.roll

            DispatchQueue.main.async {
                self.updateOffsets(pitch: pitch, roll: roll)
            }
        }
    }


    private func updateOffsets(pitch: Double, roll: Double) {
        offsets.indices.forEach { index in
            let randomOffset = CGSize(width: CGFloat.random(in: -50...50), height: CGFloat.random(in: -50...50))
            offsets[index] = CGSize(width: CGFloat(roll) * 100 + randomOffset.width, height: CGFloat(pitch) * 100 + randomOffset.height)
        }
    }

    private func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
