//
//  UserInfoSettingView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/12.
//

import SwiftUI

struct UserInfoSettingView: View {
    @Environment(\.dismiss) var dismiss
    
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
            VStack(spacing: 0) {
                titleContainer("정확한 자세 코칭 제공을 위해", "정보를 입력해주세요.")
                    .padding(.horizontal, 30)
                Spacer()
                Spacer()
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
                                        
    private func dateFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."

        let currentDate = date
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
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
            dismiss()
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
