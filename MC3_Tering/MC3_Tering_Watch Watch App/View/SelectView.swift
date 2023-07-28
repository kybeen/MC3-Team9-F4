//
//  SelectView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/28.
//

import SwiftUI

struct SelectView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("목표를 달성했어요.\n연습을 끝내시겠어요?")
                .font(.system(size: 20))
                .padding(.bottom, 16)
            Spacer()
            NavigationLink(destination: CountingView()) {
                Text("이대로 계속하기")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black)
            }
            .background(Color.watchColor.lightGreen)
            .cornerRadius(40)
            Spacer()
            NavigationLink(destination: ResultView()) {
                Text("종료")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
            }
            .background(Color.watchColor.lightBlack)
            .cornerRadius(40)
        }
        .navigationBarBackButtonHidden()
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
