//
//  TedCountingView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/26.
//

import SwiftUI

struct TedCountingView: View {
    
    @Binding var selectedValue: Int
    
    @State var progressValue: Float = 0.0
    @State var countValue: String = ""
    @State var counting: Int = 100
    @State var fontSize: CGFloat = 48.0

    var body: some View {
        VStack {
            TimeCircleProgressBar(progress: self.$progressValue, count: self.$countValue, fontSize: $fontSize)
                .frame(width: 150, height: 150, alignment: .center)

        }
        .onAppear {
            rate()
            countSwing()
        }
    }
}

extension TedCountingView {
    
    private func rate() {
        progressValue = Float(counting) / Float(selectedValue)
        print("progress \(progressValue)")
    }
    
    private func countSwing() {
        countValue = "\(counting)"
    }
}

struct TedCountingView_Previews: PreviewProvider {
    @State static var selectedValue: Int = 0 // Create a State variable to use as a Binding for preview

    static var previews: some View {
        TedCountingView(selectedValue: $selectedValue)
    }
}
