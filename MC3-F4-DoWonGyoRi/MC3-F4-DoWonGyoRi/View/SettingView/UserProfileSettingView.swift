//
//  UserProfileSettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/13.
//

import SwiftUI
import PhotosUI

struct UserProfileSettingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userDataModel: UserDataModel
    @State private var userNickname = ""
    @State private var userTitle1 = ""
    @State private var userTitle2 = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var userTitle1Array: [String] = []
    @State private var userTitle2Array: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                profilePhotoContainer()
                modifyProfileButton()
            }
            nicknameViewerContainer()
            userTitlePickerContainer()
            Spacer()
        }
        .navigationTitle("프로필 수정").foregroundColor(Color.theme.teWhite)
        .navigationBarItems(trailing: Button(action: {
            
            if userNickname != "" {
                userDataModel.username = userNickname
            }
            userDataModel.userTitle1 = userTitle1
            userDataModel.userTitle2 = userTitle2
            userDataModel.saveUserData() 
            dismiss()
        }) {
            Text("저장")
                .font(.custom("Inter-Bold", size: 16))
                .foregroundColor(Color.theme.teGreen)
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onAppear {
            userTitle1 = userDataModel.userTitle1
            userTitle2 = userDataModel.userTitle2
            userTitle1Array = userDataModel.userTitle1List
            userTitle2Array = userDataModel.userTitle2List
        }
    }
    

}

extension UserProfileSettingView {
    private func profilePhotoContainer() -> some View {
        Button(action: {
            
        }) {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(Color.theme.teGray)
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 129, maxHeight: 129)
                        .cornerRadius(100)
                } else {
                    if selectedImageData != nil {
                        Image(uiImage: UIImage(data: selectedImageData!)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 129, maxHeight: 129)
                            .cornerRadius(100)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.theme.teWhite)
                            .frame(width: 45)
                    }
                }
            }
            .frame(maxWidth: 129, maxHeight: 129)
            .padding(.bottom, 32)
        }
        .disabled(true)
    }
    
    private func modifyProfileButton() -> some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Text("사진 변경하기")
                    .font(.custom("Inter-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.theme.teGreen)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 9)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .inset(by: 0.5)
                            .stroke(Color.theme.teGreen, lineWidth: 1)
                    )
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        
    }
    
    private func nicknameViewerContainer() -> some View {
        List {
            Section(content: {
                Button(action: {
                    
                }) {
                    TextField(userDataModel.username, text: $userNickname)
                        .font(.custom("Inter-Medium", size: 16))
                        .foregroundColor(.gray)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
                .frame(maxHeight: 60)
            }, header: {
                Text("닉네임")
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .padding(.bottom, 15)
            })
            
        }
        .frame(maxHeight: 185)
    }
    
    private func userTitlePickerContainer() -> some View {
        VStack(spacing: 0) {
            Text("칭호")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(Color.theme.teWhite)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.bottom, 17)
                .padding(.leading, 18)
            
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .padding(.horizontal, 10)
                        .foregroundColor(Color.theme.teGreen)
                    Picker("타이틀1", selection: $userTitle1, content: {
                        ForEach(userDataModel.userTitle1List, id: \.self) {
                            Text("\($0)")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(userTitle1 == $0 ? Color.theme.teBlack : Color.theme.teWhite)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 10)
                        }
                    })
                }
                .presentationDetents([.fraction(0.4)])
                .pickerStyle(.wheel)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .padding(.horizontal, 10)
                        .foregroundColor(Color.theme.teSkyBlue)
                    Picker("타이틀2", selection: $userTitle2, content: {
                        ForEach(userTitle2Array, id: \.self) {
                            Text("\($0)")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(userTitle2 == $0 ? Color.theme.teBlack : Color.theme.teWhite)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                        }
                    })
                }
                .frame(alignment: .leading)
                .presentationDetents([.fraction(0.4)])
                .pickerStyle(.wheel)
            }
            
            .background(Color.theme.teDarkGray)
            .cornerRadius(20)
        }
        .padding(.horizontal, 18)
        .frame(maxHeight: 210)
    }
    
}




struct UserProfileSettingView_Preview: PreviewProvider {
    @ObservedObject static var userDataModel = UserDataModel.shared
    static var previews: some View {
        UserProfileSettingView(userDataModel: userDataModel)
    }
}
