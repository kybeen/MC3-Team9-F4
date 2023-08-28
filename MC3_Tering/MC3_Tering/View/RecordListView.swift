//
//  RecordListView.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/08/28.
//

import SwiftUI

struct RecordListView: View {
    let months = ["2023년 7월", "2023년 8월", "2023년 9월"] // 월 데이터
    let swingCount = 120
    var body: some View {
            ForEach(months, id: \.self) { month in
                Section(
                    header: Text(month)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Inter-Bold", size: 20))
                        .foregroundColor(Color.theme.teWhite)
                        .padding(.bottom, 12)
                        .padding(.top, 30)
                ) {
                    ForEach(1..<32, id: \.self) { day in
                        NavigationLink(destination: {
                            
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.theme.teDarkGray)
                                    .cornerRadius(15)
                                
                                    .frame(height: 100)
                                
                                HStack(spacing: 0) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.theme.teBlack)
                                            .frame(width: 50)
                                        Image("forehandicon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            
                                            Text("\(swingCount)/\(swingCount)")
                                                .font(.custom("Inter-Regular", size: 24))
                                            Text("SWING")
                                                .frame(height: 25, alignment: .bottom)
                                                .font(.custom("Inter-Regular", size: 16))
                                                
                                        }
                                        .frame(alignment: .bottom)
                                        .foregroundColor(Color.theme.teGreen)
                                        HStack(spacing: 0) {
                                            Text("\(swingCount)/\(swingCount)")
                                                .font(.custom("Inter-Regular", size: 24))
                                            Text("PER")
                                                .frame(height: 25, alignment: .bottom)
                                                .font(.custom("Inter-Regular", size: 16))
                                        }
                                        .foregroundColor(Color.theme.teSkyBlue)
                                    }
                                    .padding(.leading, 16)
                                    Spacer()
                                    VStack(spacing: 0) {
                                        HStack(spacing: 0) {
                                            Text("2023. 8. 26  ")
                                                .font(.custom("Inter-Regular", size: 12))
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 10)
                                        }
                                    }
                                    .foregroundColor(Color.theme.teLightGray)
                                    .frame(height: 56, alignment: .bottom)
                                    
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 16)
                            }
                        }
                            
                    }
                }
            }
        }
    
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
