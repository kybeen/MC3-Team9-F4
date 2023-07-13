//
//  UserInfoSettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/12.
//

import SwiftUI

struct UserInfoSettingView: View {
    @State private var height: Double = 170
    @State private var weight: Double = 60
    @State private var age: Int = 25
    @State private var isSetAge: Bool = false
    @State private var isSetWeight: Bool = false
    @State private var isSetHeight: Bool = false
    @State private var isLeftHand: Bool = false
    private let sexList = ["남성", "여성", "기타"]
    @State private var sex = "남성"
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                titleContainer("정확한 자세 코칭 제공을 위해", "정보를 입력해주세요.")
                    .padding(.horizontal, 30)
                Spacer()
                Spacer()
                List {
                    Section {
                        HStack(spacing: 0) {
                            Text("생년월일")
                                .foregroundColor(Color.theme.teWhite)
                            Spacer()
                            Text("")
                                .foregroundColor(.gray)
                        }
                        .frame(height: 45)
                        
                        Button(action: {
                            isSetHeight.toggle()
                        }) {
                            HStack {
                                Text("키 (cm)")
                                    .foregroundColor(Color.theme.teWhite)
                                Spacer()
                                Text("\(Int(height))")
                                    .foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $isSetHeight, content: {
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
                            Picker("성별", selection: $age, content: {
                                ForEach(sexList, id: \.self) {
                                    Text($0)
                                }
                            })
                            .presentationDetents([.fraction(0.4)])
                            .pickerStyle(.wheel)
                            
                        })
                        .frame(height: 45)
                    }
                    
                    Section {
                        HStack {
                            Toggle(isOn: $isLeftHand) {
                                Text("왼손잡이")
                            }
                        }
                        .frame(height: 45)
                        
                    }
                }
                saveButton("저장")
                    .padding(.horizontal, 18)
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
        }
    }
}

extension UserInfoSettingView {
    private func titleContainer(_ title1: String, _ title2: String) -> some View {
        
        Text("\(title1)\n\(title2)")
            .font(.custom("Inter-Medium", size: 24))
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            .foregroundColor(Color.theme.teWhite)
            
    }
    
    private func saveButton(_ buttonTitle: String) -> some View {
        
        return Button(action: {
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color.theme.teGreen)
                    .cornerRadius(30)
                Text(buttonTitle)
                    .foregroundColor(Color.theme.teBlack)
                    .font(.custom("Inter-Bold", size: 16))
            }
        }
    }
}

struct UserInfoSettingView_Preview: PreviewProvider {
    @State static var array: [Int] = []
    static var previews: some View {
        UserInfoSettingView()
    }
}
