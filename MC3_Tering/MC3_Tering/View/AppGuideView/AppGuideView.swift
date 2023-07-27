//
//  AppGuideView.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/07/27.
//

import SwiftUI

struct AppGuideView: View {
    @Environment(\.dismiss) var dismiss
    @State var guidePage = 0
    @Binding var isFirstGuide: Bool
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image("guide_Xbutton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 57)
            }
            .padding(.bottom, 38)
            
            ZStack {
                Image("WatchOnboarding\(guidePage + 1)")
                    .resizable()
                    .scaledToFit()
                    
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        Button(action: {
                            guidePage -= 1
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundColor(guidePage == 0 ? .clear : Color.theme.teGreen)
                        }
                        .disabled(guidePage == 0 ? true : false)
                        Spacer()
                        Button(action: {
                            guidePage += 1
                        }) {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundColor(guidePage == 2 ? .clear : Color.theme.teGreen)
                        }
                        .disabled(guidePage == 2 ? true : false)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    Button(action: {
                        isFirstGuide = false
                    }) {
                        VStack(spacing: 0) {
                            Text("다시 보지않기")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color.theme.teGreen)
                                .padding(.bottom, 5)
                            Rectangle()
                                .frame(height: 1.5)
                                .foregroundColor(Color.theme.teGreen)
                        }
                        .frame(width: 70)
                    }
                    .padding(.bottom, 24)
                }
            }
            .frame(maxWidth: 321, maxHeight: 520)
        }
        .background(.clear)
        
    }
        
}
//
//struct AppGuideView_Previewer: PreviewProvider {
//    static var previews: some View {
//        AppGuideView(, isFirst: <#Binding<Bool>#>)
//    }
//}
