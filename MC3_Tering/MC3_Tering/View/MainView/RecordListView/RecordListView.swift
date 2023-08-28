//
//  RecordListView.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/08/28.
//

import SwiftUI

struct RecordListView: View {
    @ObservedObject var workoutDataModel: WorkOutDataModel
    @State var months: [String: [WorkOutData]] = [:]
    let swingCount = 120
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d." // 원하는 날짜 형식을 설정합니다.
        return formatter
    }()
    
    var body: some View {
        ForEach(months.keys.sorted(by: >), id: \.self) { monthKey in
                Section(
                    header: Text("\(monthKey)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Inter-Bold", size: 20))
                        .foregroundColor(Color.theme.teWhite)
                        .padding(.bottom, 12)
                        .padding(.top, 30)
                ) {
                    ForEach(months[monthKey]!.sorted { $0.workoutDate ?? Date() > $1.workoutDate ?? Date() }, id: \.self) { data in
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
                                            
                                            Text("\(data.totalSwingCount)/\(swingCount)")
                                                .font(.custom("Inter-Regular", size: 24))
                                            Text("SWING")
                                                .frame(height: 25, alignment: .bottom)
                                                .font(.custom("Inter-Regular", size: 16))
                                                
                                        }
                                        .frame(alignment: .bottom)
                                        .foregroundColor(Color.theme.teGreen)
                                        HStack(spacing: 0) {
                                            Text("\(data.forehandPerfect + data.backhandPerfect)/\(data.totalSwingCount)")
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
                                            Text("\(dateFormatter.string(from: data.workoutDate ?? Date()))  ")
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
    @ObservedObject static var workoutDataModel = WorkOutDataModel.shared
    @State static var workout = [WorkOutData()]
    @State static var months = ["" : [WorkOutData()]]
    static var previews: some View {
        RecordListView(workoutDataModel: workoutDataModel, months: months)
    }
}
