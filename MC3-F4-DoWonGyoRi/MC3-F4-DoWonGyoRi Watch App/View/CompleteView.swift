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
        .navigationBarBackButtonHidden()
        .background(
            NavigationLink(destination: CountingView(), isActive: $isResultViewPresented) {
                EmptyView()
            }
            .hidden()
        )
    }
    
    func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 2.0)) {
                self.progressValue = 1
            }
        }
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
