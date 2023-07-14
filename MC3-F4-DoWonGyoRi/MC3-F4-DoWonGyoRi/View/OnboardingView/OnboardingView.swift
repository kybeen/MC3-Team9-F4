//
//  OnboardingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/14.
//

import SwiftUI
import PhotosUI
struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var nickname = ""
    @State private var handSelect = "손을 선택해주세요"
    
    /**
     UserInfoSettingView와 겹치는 변수
     */
    @State private var height = 170
    @State private var weight = 60
    @State private var isSetAge: Bool = false
    @State private var isSetWeight: Bool = false
    @State private var isSetHeight: Bool = false
    @State private var isSetBirthDay: Bool = false
    @State private var isLeftHand: Bool = true
    @State private var selectedDate = Date()
    private let sexList = ["남성", "여성", "기타"]
    @State private var sex = "남성"
//    @State private var viewBirthdady = (selectedDate.formatted(.iso8601).substring(to: )
    
    let startDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1))!
    let endDate = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            titleContainer("꼭 맞는 자세 교정", "을 위해", "추가정보를 입력해주세요.")
            Spacer()
//            welcomeCommentContainer()
//                .padding(.horizontal, 24)
//            profileContainer()
//            handSelectContainer()
            additionalDataInput()
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
    
    private func additionalDataInput() -> some View {
        List {
            Section {
                
                Button(action: {
                    isSetBirthDay.toggle()
                }) {
                    HStack(spacing: 0) {
                        Text("생년월일")
                            .foregroundColor(Color.theme.teWhite)
                        Spacer()
                        Text(dateFormat(selectedDate))
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isSetBirthDay, content: {
                    HStack(spacing: 0) {
                        VStack {
                            
                            HStack(spacing: 0) {
                                Button(action: {
                                    isSetBirthDay.toggle()
                                }) {
                                    Text("취소")
                                        .font(.custom("Inter-Bold", size: 16))
                                        .foregroundColor(Color.theme.teWhite)
                                }
                                Spacer()
                                Button(action: {
                                    isSetBirthDay.toggle()
                                }) {
                                    Text("완료")
                                        .font(.custom("Inter-Bold", size: 16))
                                        .foregroundColor(Color.theme.teGreen)
                                }
                            }
                            .padding(.horizontal, 28)
                            .padding(.vertical, 24)
                            
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                in: startDate...endDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(height: 200)
                            .padding()
                            .environment(\.locale, .init(identifier: "ko_KR"))
                            .onChange(of: selectedDate, perform: { date in
                                if selectedDate > endDate {
                                    selectedDate = endDate
                                }
                            })
                        }
                        .presentationDetents([.fraction(0.4)])
                        
                        
                    }
                })
                .frame(height: 45)
                
                Button(action: {
                    isSetHeight.toggle()
                }) {
                    HStack {
                        Text("키 (cm)")
                            .foregroundColor(Color.theme.teWhite)
                        Spacer()
                        Text("\(Int(height))cm")
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isSetHeight, content: {
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            isSetHeight.toggle()
                        }) {
                            Text("취소")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teWhite)
                        }
                        Spacer()
                        Button(action: {
                            isSetHeight.toggle()
                        }) {
                            Text("완료")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teGreen)
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 24)
                    
                    Picker("키", selection: $height, content: {
                        ForEach(130 ... 240, id: \.self) {
                            Text("\($0)cm")
                        }
                    })
                    .presentationDetents([.fraction(0.4)])
                    .pickerStyle(.wheel)
                    
                })
                .frame(height: 45)
                
                Button(action: {
                    isSetWeight.toggle()
                }) {
                    HStack {
                        Text("체중 (kg)")
                            .foregroundColor(Color.theme.teWhite)
                        Spacer()
                        Text("\(Int(weight))kg")
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isSetWeight, content: {
                    HStack(spacing: 0) {
                        Button(action: {
                            isSetWeight.toggle()
                        }) {
                            Text("취소")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teWhite)
                        }
                        Spacer()
                        Button(action: {
                            isSetWeight.toggle()
                        }) {
                            Text("완료")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teGreen)
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 24)
                    
                    Picker("체중", selection: $weight, content: {
                        ForEach(30 ... 300, id: \.self) {
                            Text("\($0)kg")
                        }
                    })
                    .presentationDetents([.fraction(0.4)])
                    .pickerStyle(.wheel)
                    
                })
                .frame(height: 45)
                
                Button(action: {
                    isSetAge.toggle()
                }) {
                    HStack {
                        Text("성별")
                            .foregroundColor(Color.theme.teWhite)
                        Spacer()
                        Text(sex)
                            .foregroundColor(.gray)
                        
                    }
                    
                }
                .sheet(isPresented: $isSetAge, content: {
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            isSetAge.toggle()
                        }) {
                            Text("취소")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teWhite)
                        }
                        Spacer()
                        Button(action: {
                            isSetAge.toggle()
                        }) {
                            Text("완료")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.theme.teGreen)
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 24)
                    
                    Picker("성별", selection: $sex, content: {
                        ForEach(sexList, id: \.self) {
                            Text($0)
                        }
                    })
                    .presentationDetents([.fraction(0.4)])
                    .pickerStyle(.wheel)
                    
                })
                .frame(height: 45)
            }
        }
    }
    
    private func dateFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."

        let currentDate = date
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
}
