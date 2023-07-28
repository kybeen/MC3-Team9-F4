//
//  GuideView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
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
                .padding(.vertical, 30)
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
        let screenSize = UIScreen.main.bounds.width
        return ZStack(alignment: .bottom) {
            GifView(gifName: "\(position)Swing")
                .scaledToFill()
                .frame(width: screenSize)
                .cornerRadius(20)
            Rectangle()
                .foregroundColor(Color.theme.teDarkGray.opacity(0.6))
                .frame(height: 80)
            HStack(spacing: 0) {
                Image("\(position)icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.trailing, 10)
                Text(position.uppercased())
                    .font(.custom("Inter-Medium", size: 24))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(maxWidth: screenSize, maxHeight: 430)
        .padding(.bottom, 17)
    }
}
