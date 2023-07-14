//
//  MeasuringView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/12.
//

import SwiftUI

struct MeasuringView: View {
    @State private var isSwingResultViewPresented = false
    @State private var dot: String = ""
    
    var body: some View {
        VStack {
            Text("측정 중")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isSwingResultViewPresented = true
            }
        }
        .background(
            NavigationLink(destination: SwingResultView(), isActive: $isSwingResultViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .navigationBarBackButtonHidden()
    }
}

struct MeasuringView_Previews: PreviewProvider {
    static var previews: some View {
        MeasuringView()
    }
}
