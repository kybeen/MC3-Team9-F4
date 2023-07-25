//
//  SeettingView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var userDataModel: UserDataModel
    
    var body: some View {
        VStack(spacing: 0) {
            profilePhotoContainer()
            namespaceContainer()
            modifyProfileButton()
            navigationLinkContainer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct SettingView_Proviewr: PreviewProvider {
    @ObservedObject static var userDataModel = UserDataModel.shared
    static var previews: some View {
        SettingView(userDataModel: userDataModel)
    }
}

extension SettingView {
    private func profilePhotoContainer() -> some View {
        Button(action: {
            
        }) {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(Color.theme.teGray)
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.theme.teWhite)
                    .frame(width: 45)
            }
            .frame(maxWidth: 129, maxHeight: 129)
            .padding(.bottom, 32)
        }
        .disabled(true)
    }
    
    private func namespaceContainer() -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(userDataModel.userTitle1)
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.trailing, 10)
                Text(userDataModel.userTitle2)
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.theme.teSkyBlue)
                    
            }
            .padding(.bottom, 20)
            Text(userDataModel.username)
                .font(.custom("Inter-Bold", size: 24))
                .foregroundColor(Color.theme.teWhite)
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
        .padding(.bottom, 24)
    }
    
    private func modifyProfileButton() -> some View {
        NavigationLink(destination: UserProfileSettingView(userDataModel: userDataModel)) {
            Text("프로필 수정")
                .font(.custom("Inter-Bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.teGreen)
                .padding(.horizontal, 28)
                .padding(.vertical, 9)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.24, green: 0.95, blue: 0.23), lineWidth: 1)
                )
        }
        .padding(.bottom, 15)
                       
    }
    
    private func navigationLinkContainer() -> some View {
        VStack(spacing: 0) {
            navigationLinkButtonSet("내 신체 정보", UserInfoSettingView(userDataModel: userDataModel))
            navigationLinkButtonSet("포핸드 목표 설정", UserStrokeSettingView(userDataModel: userDataModel, isBackhandSetting: false))
            navigationLinkButtonSet("백핸드 목표 설정", UserStrokeSettingView(userDataModel: userDataModel, isBackhandSetting: true))
        }
    }
    
    private func navigationLinkButtonSet<Destination: View>(_ buttonName: String, _ destination: Destination) -> some View {
        VStack(spacing: 0) {
            NavigationLink(destination: destination) {
                HStack(spacing: 0) {
                    Text(buttonName)
                        .font(.custom("Inter-Bold", size: 16))
                        .foregroundColor(Color.theme.teWhite)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 17)
                        .foregroundColor(Color.theme.teWhite)
                }
            }
            .padding(.vertical, 35)
            .padding(.horizontal, 47.5)
            Rectangle()
                .foregroundColor(Color.theme.teWhite)
                .frame(maxWidth: UIScreen.main.bounds.width - 36)
                .frame(height: 1)
                .padding(.leading, 36)

        }
    }
}
