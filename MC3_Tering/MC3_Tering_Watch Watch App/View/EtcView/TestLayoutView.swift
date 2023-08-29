//
//  TestLayoutView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by 김영빈 on 2023/08/29.
//

import SwiftUI

// MARK: - 레이아웃 테스트용 뷰
struct TestLayoutView: View {
    var body: some View {
        // ResultView.swift
//        VStack {
//            VStack(spacing: 0) {
//                Spacer()
//                Text("00:00:00")
//                    .font(.system(size: 40, weight: .medium))
//                    .foregroundColor(Color.watchColor.lightGreen)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.top, 15)
//                    .padding(.bottom, 3)
//                Text("72 bpm")
//                    .font(.system(size: 28, weight: .medium))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.bottom, 3)
//                Text("2 kcal")
//                    .font(.system(size: 28, weight: .medium))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.bottom, 3)
//                Spacer()
//            }
//
//            NavigationLink(destination: SwingCountView()) {
//                Text("완료")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(Color.black)
//            }
//            .foregroundColor(Color.watchColor.black) // 2
//            .background(Color.watchColor.lightGreen) // 3
//            .cornerRadius(40)
//        }
//        .padding(.horizontal, 5)
        
        // Countingview.swift
//        VStack(spacing: 0) {
//            Text("00:00:00")
//                .font(.system(size: 40, weight: .medium))
//                .foregroundColor(Color.watchColor.lightGreen)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 7)
//            Text("N번의 스윙이 남았어요. \n연습을 끝내시겠어요?")
//                .font(.system(size: 15))
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 25)
////                Text("연습을 끝내시겠어요?")
//            NavigationLink(destination: SwingCountView()) {
//                Button("종료") {
//                    print("test")
//                }
//                .font(.system(size: 20, weight: .semibold))
//                .foregroundColor(Color.white)
//                .background(Color.watchColor.lightBlack)
//                .cornerRadius(40)
//            }
//            .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove button visuals
//        }
//        .padding(.horizontal, 5)
        
        
//        // SelectView.swift
//    VStack(spacing: 0) {
//        Text("목표를 달성했어요. \n연습을 끝내시겠어요?")
//            .font(.system(size: 20))
//            .frame(maxWidth: .infinity, alignment: .leading)
//        Spacer()
//
//        NavigationLink(destination: CountingView()) {
//            Text("이대로 계속하기")
//                .font(.system(size: 20, weight: .bold))
//                .foregroundColor(Color.black)
//        }
//        .background(Color.watchColor.lightGreen)
//        .cornerRadius(40)
//        .padding(.bottom, 11)
//
//        NavigationLink(destination: ResultView(workoutDataModel: WorkOutDataModel()), label: {
//            Button("종료") {
//                print("test")
//            }
//            .font(.system(size: 20, weight: .semibold))
//            .foregroundColor(Color.white)
//            .background(Color.watchColor.lightBlack)
//            .cornerRadius(40)
//        })
//        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove button visuals
//    }
//    .padding(.horizontal, 5)
        
        
        // 10초 미만 결과화면
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 35, height: 33)
                    .padding(.top, 7)
                    .padding(.bottom, 6)
                Text("10초 미만의 운동 데이터는\n저장되지 않습니다.")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
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
