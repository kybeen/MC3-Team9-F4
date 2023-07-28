//
//  SwingResultView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct SwingResultView: View {
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    @State private var isSwingCountViewPresented = false
    @State private var isSwingCompleteViewPresented = false
    
//    @Binding var selectedValue: Int
    
    @EnvironmentObject var swingInfo: SwingInfo
    
    @State var resultColor: Color
    @State var swingResult = ""
    @State var swingClassifier = ""
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(resultColor)
                .frame(width: 150, height: 150, alignment: .center)
            
//                Text("\(tennisClassifierViewModel.classLabel)") //MARK: 테스트용
//                //Forehand, Backhand
                
            //TODO: 결과에 따른 색상 처리 필요
            Text("\(tennisClassifierViewModel.resultLabel)!")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.watchColor.black)
                //Perfect, Bad

            VStack {
                Spacer()
                Text("\(swingResult) \(swingClassifier)였어요")
                    .padding(.bottom, 16)
            }
            .ignoresSafeArea()

        }
        .onAppear {
            calculateSwings()
            getSwingResult()
            getSwingColor()
            swingCompleteView()
        }
        .background(
            NavigationLink(destination: CountingView(), isActive: $isSwingCountViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .background(
            NavigationLink(destination: SwingCompleteView(), isActive: $isSwingCompleteViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .navigationBarBackButtonHidden()
    }
}

extension SwingResultView {
    
    private func calculateSwings() {
        swingInfo.totalSwingCount! += 1
        
        if tennisClassifierViewModel.classLabel == "Forehand" {
            if tennisClassifierViewModel.resultLabel == "PERFECT" {
                swingInfo.forehandPerfect! += 1
            }
            swingInfo.totalForehandCount! += 1
        } else {    //Backhand
            if tennisClassifierViewModel.resultLabel == "PERFECT" {
                swingInfo.backhandPerfect! += 1
            }
            swingInfo.totalBackhandCount! += 1
        }
        
        print("totalSwingCount -> \(swingInfo.totalSwingCount)")
        print("totalForehandCount -> \(swingInfo.totalForehandCount)")
        print("totalBackhandCount -> \(swingInfo.totalBackhandCount)")
        print("ForehandPerfect -> \(swingInfo.forehandPerfect)")
        print("BackhandPerfect -> \(swingInfo.backhandPerfect)")

    }
    
    private func getSwingResult() {
        if tennisClassifierViewModel.resultLabel == "PERFECT" {
            swingResult = "멋진"
        } else { swingResult = "아쉬운" }
        
        if tennisClassifierViewModel.classLabel == "Forehand" {
            swingClassifier = "포핸드"
        } else { swingClassifier = "백핸드" }
    }
    
    private func getSwingColor() {
        if tennisClassifierViewModel.resultLabel == "PERFECT" {
            resultColor = Color.watchColor.lightGreen
        } else { resultColor = Color.watchColor.pink }
    }
    
    private func swingCompleteView() {
        if swingInfo.selectedValue! == swingInfo.totalSwingCount! {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isSwingCompleteViewPresented = true
            }
            print("달성 완료 @@@")
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isSwingCountViewPresented = true
            }
        }        
    }
    
}

struct SwingResultView_Previews: PreviewProvider {
    @State static var selectedValue: Int = 5 // Create a State variable to use as a Binding for preview

    @State static var resultColor = Color.watchColor.lightGreen
    
    static var previews: some View {
        SwingResultView(resultColor: resultColor)
    }
}
