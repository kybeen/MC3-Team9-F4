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
        if months.isEmpty {
                Text("스윙 데이터가 존재하지 않습니다.")
                    .font(.custom("Inter-Medium", size: 16))
                    .padding(.top, 100)
                    .opacity(0.5)
        }
        
        
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
                            RecordDetailView(detailDay: data.workoutDate ?? Date(), totalSwingCount: Int(data.totalSwingCount), targetSwingCount: 120, perfectSwingCount: Int(data.backhandPerfect + data.forehandPerfect), workoutTime: Int(data.workoutTime), calorieBurn: Int(data.burningCalories))
//                            RecordDetailView(detailDay: Date(), totalSwingCount: 120, targetSwingCount: 240, perfectSwingCount: 80, workoutTime: 60, calorieBurn: Int(data.burningCalories))
                            
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
