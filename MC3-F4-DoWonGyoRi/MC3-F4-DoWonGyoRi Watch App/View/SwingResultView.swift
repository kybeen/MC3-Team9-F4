//
//  SwingResultView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI

struct SwingResultView: View {
    @State private var isSwingCountViewPresented = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 150, height: 150, alignment: .center)
            Text("BAD!")
                .font(.system(size: 32, weight: .semibold))
                .foregroundColor(Color.watchColor.black)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isSwingCountViewPresented = true
            }
        }
        .background(
            NavigationLink(destination: CountingView(), isActive: $isSwingCountViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .navigationBarBackButtonHidden()
    }
}

struct SwingResultView_Previews: PreviewProvider {
    static var previews: some View {
        SwingResultView()
    }
}
