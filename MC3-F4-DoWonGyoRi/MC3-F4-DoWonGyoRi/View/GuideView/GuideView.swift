//
//  GuideView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI
import AVKit

struct GuideView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.theme.teBlack.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.theme.teWhite)
                            .frame(maxWidth: 17)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding(.horizontal, 36)
                .padding(.bottom, 30)
                VStack(spacing: 0) {
                    Text("테니스 가이드")
                        .font(.custom("Inter-Medium", size: 20))
                        .foregroundColor(Color.theme.teGreen)
                        .padding(.bottom, 6)
                    Rectangle()
                        .frame(width: 138, height: 3)
                        .foregroundColor(Color.theme.teGreen)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.horizontal, 30)
                
                ScrollView {
                    guideContainer("forehand")
                        .padding(.bottom, 17)
                    guideContainer("backhand")
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding(.top, 38)
            }
        }
        
    }
    
}

struct GuideView_Preview: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}

extension GuideView {
    private func guideContainer(_ position: String) -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .infinity, height: 431)
                .background(Color(red: 0.29, green: 0.29, blue: 0.29))
                .cornerRadius(15)
                .shadow(color: .black, radius: 15, x: 20, y: 20)
                .shadow(color: Color(red: 0.34, green: 0.34, blue: 0.34).opacity(0.2), radius: 23, x: -10, y: -10)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .infinity, height: 118)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color.theme.teDarkGray, location: 0.00),
                            Gradient.Stop(color: Color.theme.teDarkGray.opacity(0), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.08).opacity(0.48), location: 0.57),
                            Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.08), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .cornerRadius(15)
            Text(position.uppercased())
                .font(.custom("Inter-Medium", size: 24))
                .foregroundColor(Color.theme.teWhite)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.leading, 35)
                .padding(.bottom, 45)
            
            GifView(gifName: "dancing")
                .scaledToFit()
                .frame(width: 250)
                .padding(.bottom, 100)
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 430)
    }
}
