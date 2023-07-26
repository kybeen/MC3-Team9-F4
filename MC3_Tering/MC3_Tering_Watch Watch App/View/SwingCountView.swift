//
//  SwingCountView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

import SwiftUI

//MARK: - 시작 버튼 맨 밑으로 보내기

struct SwingCountView: View {
    let swingList: SwingList
    @State private var isReadyViewActive = false
    @State private var strokeCount = 10

    @StateObject var healthManager = HealthKitManager()

    @EnvironmentObject var healthInfo: HealthStartInfo // Access the shared instance
    @EnvironmentObject var healthResultInfo: HealthResultInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 목표 스윙 개수는\n얼마인가요?")
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            HStack {
//                countViewContainer()
                testView()
            }
            Spacer()
            NavigationLink(destination: ReadyView()) {
                Text("시작")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
            }
            .background(Color.watchColor.lightGreen)
            .cornerRadius(40)
        }
        .onAppear {
            healthManager.requestAuthorization()
            healthManager.readCurrentCalories()
            
            //MARK: - 클린 코드
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                getCurrentInfo()
            }
            
        }
        .navigationTitle("목록")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwingCountView_Previews: PreviewProvider {
    static var previews: some View {
        SwingCountView(swingList: swingLists[0])
    }
}

//MARK: - Extension

extension SwingCountView {
    private func getCurrentInfo() {
        healthInfo.startCal = healthManager.currentCalories
        
        healthInfo.startTime = Date()
        
        print("time -> \(healthInfo.startTime)")
    }
    
//    private func countViewContainer() -> some View {
//        VStack(spacing: 0) {
//            HStack(spacing: 0) {
//                Button(action: {
//                    if strokeCount > 10 {
//                        strokeCount -= 10
//                    }
//                }) {
//                    Image(systemName: "minus.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(Color.watchColor.lightGreen)
//                        .frame(maxWidth: 32)
//                }
//                Spacer()
//                Text("\(strokeCount)")
//                    .font(.system(size: 40, weight: .medium))
//                    .foregroundColor(Color.white)
//                Spacer()
//                Button(action: {
//                    if strokeCount < 300 {
//                        strokeCount += 10
//                    }
//                }) {
//                    Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(Color.watchColor.lightGreen)
//                        .frame(maxWidth: 32)
//                }
//            }
////            .frame(maxWidth: 267)
//        }
//
//    }
}


struct testView: View {
    @State private var valueIndex: Int = 0
    let stepSize = 10
    let values: [Int]

    init() {
        // Create an array from 0 to 100 (inclusive) with a step of 10
        var tempValues: [Int] = []
        for i in stride(from: 0, through: 100, by: stepSize) {
            tempValues.append(i)
        }
        self.values = tempValues
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: decrementValue) {
                    Image(systemName: "minus.fill")
                        .foregroundColor(Color.black)
                }
                .background(Color.watchColor.lightGreen)
                .clipShape(Circle())
                .padding()

                Picker("Value", selection: $valueIndex) {
                    ForEach(0..<values.count) { index in
                        Text("\(values[index])")
                    }
                }
                .pickerStyle(WheelPickerStyle()) // Set the picker style to WheelPickerStyle
                .labelsHidden()
                

                Button(action: incrementValue) {
                    Image(systemName: "plus.fill")
                        .foregroundColor(Color.black)
                }
                .background(Color.watchColor.lightGreen)
                .clipShape(Circle())
                .padding()
            }
        }
    }

    private func incrementValue() {
        if valueIndex < values.count - 1 {
            valueIndex += 1
        }
    }

    private func decrementValue() {
        if valueIndex > 0 {
            valueIndex -= 1
        }
    }
}
