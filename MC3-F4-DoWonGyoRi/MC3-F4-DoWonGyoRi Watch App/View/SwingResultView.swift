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
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 150, height: 150, alignment: .center)
                Text("PERFECT! or BAD!")
                    .foregroundColor(Color.watchColor.black)
            }
            Spacer()
            Text("잘 쳤는지 아닌 지")
                .font(.system(size: 12, weight: .bold))
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
