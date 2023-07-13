//
//  CompleteView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI

struct CompleteView: View {
    @State private var progressValue: Float = 0.0
    @State private var message: String = "스윙완료!"
    @State private var isResultViewPresented: Bool = false
    @State private var fontSize: CGFloat = 24.0

    var body: some View {
        VStack {
            CircleProgressBar(progress: self.$progressValue, count: self.$message, fontSize: self.$fontSize)
                .frame(width: 150, height: 150, alignment: .center)
                .onAppear {
                    //초기화
                    progressValue = 0.0
                    startProgressAnimation()
                }
        }
//        .navigationBarBackButtonHidden()
        .background(
            NavigationLink(destination: ResultView(), isActive: $isResultViewPresented) {
                EmptyView()
            }
            .hidden()
        )
    }
    
    private func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.progressValue = 1
                
                if self.progressValue == 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isResultViewPresented = true
                    }
                }
            }
        }
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
