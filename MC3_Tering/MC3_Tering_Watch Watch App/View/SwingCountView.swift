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
    
    @StateObject var healthManager = HealthKitManager()

    @EnvironmentObject var healthInfo: HealthStartInfo // Access the shared instance
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 목표 스윙 개수는\n얼마인가요?")
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            HStack {
                Text("개수 넣는 공간")
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
}
