//
//  SettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/12.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack(spacing: 0) {
            namespaceContainer()
        }
    }
}

struct SettingView_Proviewr: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

extension SettingView {
        
    
    private func namespaceContainer() -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(title1)
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.trailing, 10)
                Text(title2)
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.theme.teSkyBlue)
                    
            }
            .padding(.bottom, 20)
            Text(nickname)
                .font(.custom("Inter-SemiBold", size: 24))
                .foregroundColor(Color.theme.teWhite)
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 150, alignment: .center)
    }
}
