//
//  TestLayoutView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by 김영빈 on 2023/08/29.
//

import SwiftUI

struct TestLayoutView: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Spacer()
                Text("00:00:00")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(Color.watchColor.lightGreen)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
                    .padding(.bottom, 3)
                Text("72 bpm")
                    .font(.system(size: 28, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 3)
                Text("2 kcal")
                    .font(.system(size: 28, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 3)
                Spacer()
            }

            NavigationLink(destination: SwingCountView()) {
                Text("완료")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black)
            }
            .foregroundColor(Color.watchColor.black) // 2
            .background(Color.watchColor.lightGreen) // 3
            .cornerRadius(40)
        }
        .padding(.horizontal, 5)
    }
}

struct TestLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        TestLayoutView()
    }
}
