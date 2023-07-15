//
//  CongreteModalView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/16.
//

import SwiftUI

struct CongreteModalView: View {
    @State private var wish = false
    @State private var finishWish = false
    
    var body: some View {
        ZStack {
            modalContainer()
            
            EmitterView()
                .opacity(wish ? 1 : 0)
                .ignoresSafeArea()
        }
        .onAppear {
            doAnimation()
        }
    }
    
    
}

struct CongreteModalView_Previews: PreviewProvider {
    static var previews: some View {
        CongreteModalView()
    }
}

extension CongreteModalView {
    private func modalContainer() -> some View {
        return Text("")
    }
    
    
    
    private func doAnimation() {
        withAnimation(.spring()) {
            wish = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                finishWish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                finishWish = false
                wish = false
            }
        }
    }
}
