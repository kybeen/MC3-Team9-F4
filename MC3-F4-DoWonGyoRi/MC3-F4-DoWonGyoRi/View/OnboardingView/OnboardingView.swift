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
    @Environment(\.managedObjectContext) private var viewContext
    
    let startDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1))!
    let endDate = Date()
    private let sexList = ["남성", "여성", "기타"]
    
    @Binding var isFirst: Bool
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var handSelect = "손을 선택해주세요"
    @State private var isSetAge: Bool = false
    @State private var isSetWeight: Bool = false
    @State private var isSetHeight: Bool = false
    @State private var isSetBirthDay: Bool = false
    @State private var isLeftHand: Bool = true
    @State private var isLeftHandSelect: Bool = false
    @State private var selectedDate = Date()
    @State private var height = "170"
    @State private var weight = "60"
    @State private var nickname = ""
    @State private var sex = "남성"
    
    @State var onboardingPage = 0
    var body: some View {
        VStack(spacing: 0) {
            switch onboardingPage {
            case 0:
                titleContainer("내 정보 입력하기")
                Spacer()
                welcomeCommentContainer()
                    .padding(.horizontal, 24)
                Spacer()
                nextButton()
            case 1:
                titleContainer("프로필", "을", "입력해주세요.")
                Spacer()
                profileContainer()
                Spacer()
                nextButton()
            case 2:
                titleContainer("주로 사용하는 손", "을", "선택해주세요.")
                Spacer()
                handSelectContainer()
                Spacer()
                nextButton()
            case 3:
                titleContainer("꼭 맞는 자세 교정", "을 위해", "추가정보를 입력해주세요.")
                Spacer()
                additionalDataInput()
                Spacer()
                nextButton("시작")
            default:
                Spacer()
            }
            
        }
        .frame(maxHeight: 600)
        .padding(.horizontal, 18)
    }
}

struct OnboardingView_Previewer: PreviewProvider {
    @State static var isFirst: Bool = false
    
    static var previews: some View {
        OnboardingView(isFirst: $isFirst)
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
            if onboardingPage == 3 {
                createUser()
                createSampleWorkOutData()
                isFirst = false
            } else {
                onboardingPage += 1
                print(onboardingPage)
            }
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
                    isLeftHandSelect = true
                }) {
                    VStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .frame(maxWidth: 87)
                                .foregroundColor(isLeftHandSelect ? Color.theme.teGreen : Color.theme.teWhite)
                                .shadow(color: isLeftHandSelect ? Color.theme.teGreen : Color.theme.teBlack, radius: 20, x: -5, y: 5)
                            Image("leftHand")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 73)
                                .padding(.leading, 10)
                        }
                        .padding(.bottom, 13)
                        Text("왼손")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(isLeftHandSelect ? Color.theme.teGreen : Color.theme.teWhite)
                    }
                    Spacer()
                }
                Button(action: {
                    handSelect = "오른손"
                    isLeftHandSelect = false
                }) {
                    VStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .frame(maxWidth: 87)
                                .foregroundColor(isLeftHandSelect ? Color.theme.teWhite : Color.theme.teGreen)
                                .shadow(color: isLeftHandSelect ? Color.theme.teBlack : Color.theme.teGreen, radius: 20, x: -5, y: 5)
                            Image("rightHand")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 73)
                                .padding(.trailing, 10)
                        }
                        .padding(.bottom, 13)
                        Text("오른손")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(isLeftHandSelect ? Color.theme.teWhite : Color.theme.teGreen)
                    }
                }
                
            }
            Spacer()
        }
        .frame(maxWidth: 214, maxHeight: 160)
    }
    
    private func additionalDataInput() -> some View {
        List {
            Section {
                listComponent()
                listComponent(title: "키 (cm)", isPresented: $isSetHeight, targetData: $height, pickerList: Array(130...260).map { String($0) }, suffix: "cm")
                listComponent(title: "체중 (kg)", isPresented: $isSetWeight, targetData: $weight, pickerList: Array(30...200).map { String($0) }, suffix: "kg")
                listComponent(title: "성별", isPresented: $isSetAge, targetData: $sex, pickerList: sexList)
            }
        }
    }
    private func listComponent() -> some View {
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
            pickerPopup()
        })
        .frame(height: 54)
    }
    
    private func listComponent(title: String, isPresented: Binding<Bool>, targetData: Binding<String>, pickerList: [String], suffix: String = "") -> some View {
        Button(action: {
            isPresented.wrappedValue.toggle()
        }) {
            HStack {
                Text(title)
                    .foregroundColor(Color.theme.teWhite)
                Spacer()
                Text("\(targetData.wrappedValue)\(suffix)")
                    .foregroundColor(.gray)
            }
        }
        .sheet(isPresented: isPresented, content: {
            pickerPopup(targetData: targetData, pickerList: pickerList, isPresented: isPresented, suffix: suffix)
        })
        .frame(height: 54)
    }

    private func pickerPopup() -> some View {
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
    }
    
    private func pickerPopup(targetData: Binding<String>, pickerList: [String], isPresented: Binding<Bool>, suffix: String) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    isPresented.wrappedValue.toggle()
                }) {
                    Text("취소")
                        .font(.custom("Inter-Bold", size: 16))
                        .foregroundColor(Color.theme.teWhite)
                }
                Spacer()
                Button(action: {
                    isPresented.wrappedValue.toggle()
                }) {
                    Text("완료")
                        .font(.custom("Inter-Bold", size: 16))
                        .foregroundColor(Color.theme.teGreen)
                }
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 24)
            
            Picker("", selection: targetData, content: {
                ForEach(pickerList, id: \.self) {
                    Text("\($0)\(suffix)")
                }
            })
            .presentationDetents([.fraction(0.4)])
            .pickerStyle(.wheel)
        }
    }

    private func dateFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."
        let currentDate = date
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    private func createUser() {
        let coreDataManager = CoreDataManager.shared
        
        guard let newUserData = coreDataManager.create(entityName: "UserData", attributes: [:]) as? UserData else {
            print("Failed to create UserData object")
            return
        }
        
        newUserData.birthday = selectedDate
        newUserData.height = Int16(height) ?? 170
        newUserData.isLeftHand = isLeftHand
        newUserData.sex = Int16(sex) ?? 1
        newUserData.userTargetBackStroke = 30
        newUserData.userTargetForeStroke = 30
        newUserData.userTitle1 = "열정적인"
        newUserData.userTitle2 = "루키"
        newUserData.userTitle1_List = ["열정적인"] as NSObject
        newUserData.userTitle2_List = ["루키"] as NSObject
        newUserData.username = nickname
        newUserData.weight = Int16(weight) ?? 60
        
        coreDataManager.update(object: newUserData)
    }
    
    private func createSampleWorkOutData() {
        let coreDataManager = CoreDataManager.shared
        
        guard let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData else {
            print("Failed to create WorkOutData object")
            return
        }
        
        newWorkOutData.burningCalories = 0
        newWorkOutData.isBackhand = false
        newWorkOutData.perfectSwingCount = 0
        newWorkOutData.totalSwingCount = 0
        newWorkOutData.workoutDate = Date()
        newWorkOutData.workoutTime = 0
        
        coreDataManager.update(object: newWorkOutData)
    }
}
