//
//  UserDeviceSettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/13.
//

//import SwiftUI
//
//struct UserInfoSettingView: View {
//    @Binding var path: [Int]
//    let count: Int
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            VStack(spacing: 0) {
//                titleContainer("알맞은 자세 교정 제공을 위하여", "\(count == 1 ? "햅틱" : "소리") 크기를 설정해주세요.")
//                Spacer()
//                
//                Spacer()
//                saveButton(count == 1 ? "햅틱 세기 저장" : "소리 세기 저장")
//            }
//            .padding(EdgeInsets(top: 150, leading: 25, bottom: 90, trailing: 25))
//        }
//    }
//}
//
//extension UserInfoSettingView {
//    private func titleContainer(_ title1: String, _ title2: String) -> some View {
//        
//        Text("\(title1)\n\(title2)")
//            .font(.custom("Inter-Medium", size: 24))
//            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
//            .foregroundColor(Color.theme.teWhite)
//            
//    }
//    
//    private func saveButton(_ buttonTitle: String) -> some View {
//        
//        return Button(action: {
//            if count == 1 {
//                path.removeAll()
//                path.append(0)
//            } else {
//                path.append(count + 1)
//            }
//        }) {
//            ZStack {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(maxWidth: .infinity, maxHeight: 45)
//                    .background(Color.theme.teLightGray)
//                    .cornerRadius(30)
//                Text(buttonTitle)
//                    .foregroundColor(.white)
//                    .font(.custom("Inter-SemiBold", size: 16))
//            }
//        }
//    }
//}
//
//struct UserInfoSettingView_Preview: PreviewProvider {
//    @State static var array: [Int] = []
//    static var previews: some View {
//        UserInfoSettingView(path: $array, count: 1)
//    }
//}
