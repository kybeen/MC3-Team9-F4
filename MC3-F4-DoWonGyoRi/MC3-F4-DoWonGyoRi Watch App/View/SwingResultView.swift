//
//  SwingResultView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by KimTaeHyung on 2023/07/13.
//

import SwiftUI

struct SwingResultView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 150, height: 150, alignment: .center)
                Text("PERFECT! or BAD!")
                    .foregroundColor(Color.watchColor.black)
            }
            
            Text("잘 쳤는지 아닌 지")
                .font(.system(size: 12, weight: .bold))
        }
    }
}

struct SwingResultView_Previews: PreviewProvider {
    static var previews: some View {
        SwingResultView()
    }
}
