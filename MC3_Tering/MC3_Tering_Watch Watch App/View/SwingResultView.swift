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
    
    @Binding var selectedValue: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 150, height: 150, alignment: .center)
            VStack {
                Text("\(tennisClassifierViewModel.classLabel)").foregroundColor(.blue) //MARK: 테스트용
                //TODO: 결과에 따른 색상 처리 필요
                Text("\(tennisClassifierViewModel.resultLabel)!")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(Color.watchColor.black)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isSwingCountViewPresented = true
            }
        }
        .background(
            NavigationLink(destination: CountingView(selectedValue: $selectedValue), isActive: $isSwingCountViewPresented) {
                EmptyView()
            }
            .hidden()
        )
        .navigationBarBackButtonHidden()
    }
}

struct SwingResultView_Previews: PreviewProvider {
    @State static var selectedValue: Int = 5 // Create a State variable to use as a Binding for preview

    
    static var previews: some View {
        SwingResultView(selectedValue: $selectedValue)
    }
}
