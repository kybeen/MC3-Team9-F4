//
//  OnboardingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI
import PhotosUI
struct OnboardingView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var nickname = ""
    @State private var handSelect = "손을 선택해주세요"
    
    var body: some View {
        VStack(spacing: 0) {
            titleContainer("주로 사용하는 손", "을", "선택해주세요.")
            Spacer()
//            welcomeCommentContainer()
//                .padding(.horizontal, 24)
//            profileContainer()
            handSelectContainer()
            Spacer()
            nextButton()
        }
        .frame(maxHeight: 600)
        .padding(.horizontal, 18)
    }
}

struct OnboardingView_Previewer: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

extension OnboardingView {
    private func titleContainer(_ boldString: String, _ normalString1: String = "", _ normalString2: String = "") -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(boldString)
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(Color.theme.teWhite)
                Text(normalString1)
                    .font(.custom("Inter-Medium", size: 28))
                    .foregroundColor(Color.theme.teWhite)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(normalString2)
                .font(.custom("Inter-Medium", size: 28))
                .foregroundColor(Color.theme.teWhite)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 12)
    }
    
    private func welcomeCommentContainer() -> some View {
        ZStack {
            Color.clear
                .overlay(
                    Image("icon_background")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                )
            VStack(spacing: 0) {
                Text("테니스 플레이어님\n환영합니다!")
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.bottom, 34)
                Rectangle()
                    .foregroundColor(Color.theme.teWhite)
                    .frame(height: 1)
                Spacer()
                Text("Tering은 당신에게 알맞은 테니스 자세와\n성장의 기록을 제공합니다.\nTering과 함께 즐거운 테니스 생활을\n시작해봅시다!")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color.theme.teWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
    }
    
    private func nextButton(_ buttonTitle: String = "다음") -> some View {
        Button(action: {
            
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .background(Color.theme.teGreen)
                    .cornerRadius(30)
                Text(buttonTitle)
                    .foregroundColor(Color.theme.teBlack)
                    .font(.custom("Inter-Bold", size: 16))
            }
        }
    }
    
    private func profileContainer() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                profilePhotoContainer()
                    .padding(.top, 26)
                Spacer()
                nicknameTextField()
                Spacer()
                Spacer()
            }
            
        }
        .padding(.horizontal, 13.5)
        .scrollDisabled(true)
        .scrollIndicators(.hidden)
    }
    
    
    private func profilePhotoContainer() -> some View {
        VStack(spacing: 0) {
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
                            .frame(maxWidth: 176, maxHeight: 176)
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
                .frame(maxWidth: 176, maxHeight: 176)
                .padding(.bottom, 22)
            }
            .disabled(true)
            
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
    }
    
    private func nicknameTextField() -> some View {
        VStack(spacing: 0) {
            TextField("닉네임 입력", text: $nickname)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 14)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                }
            Rectangle()
                .frame(height: 1)
            Text("\(nickname.count)/20")
                .font(.custom("Inter-Medium", size: 15))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 6)
        }
    }
    
    private func handSelectContainer() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    handSelect = "왼손"
                }) {
                    VStack(spacing: 0) {
                        Image("left_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 87)
                            .padding(.bottom, 13)
                        Text("왼손")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(Color.theme.teWhite)
                    }
                    Spacer()
                }
                Button(action: {
                    handSelect = "오른손"
                }) {
                    VStack(spacing: 0) {
                        Image("right_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 87)
                            .padding(.bottom, 13)
                        Text("오른손")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(Color.theme.teWhite)
                    }
                }
                
            }
            Spacer()
            
            Text(handSelect)
                .font(.custom("Inter-Bold", size: 20))
                .foregroundColor(Color.theme.teWhite)
        }
        .frame(maxWidth: 214, maxHeight: 160)
    }
}
