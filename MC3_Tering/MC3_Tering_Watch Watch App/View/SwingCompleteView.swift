//
//  SwingCompleteView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/28.
//

import SwiftUI

struct SwingCompleteView: View {
    
    @State var progressValue: Float = 0.0
    @State var countValue: String = "달성완료!"
    @State var fontSize: CGFloat = 24.0
    @State private var isSelectViewPresented = false
    
    var body: some View {
        VStack(alignment: .center) {
            TimeCircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: self.$fontSize)
                .frame(width: 150, height: 150)
        }
        .onAppear {
            progressComplete()
        }
        .background(
            NavigationLink(destination: SelectView(),
                           isActive: $isSelectViewPresented) {
                EmptyView()
            }
            .hidden()
        )

        .navigationBarBackButtonHidden()
    }
}

extension SwingCompleteView {
    
    private func progressComplete() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            progressValue = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            isSelectViewPresented = true
        }
    }
    
    
}

struct SwingCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        SwingCompleteView()
    }
}
