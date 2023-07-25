//
//  TestPhoneView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct TestPhoneView: View {
    
    @ObservedObject var model = ViewModelPhone()    //데이터 불러오는 곳에 선언
    @State var reachable = "No"
    @State var messsageText = ""
    @State var numberValue = 0
    
    var body: some View {
        VStack {
            Text("Reachable \(reachable)")
            
            /**
             WCSession의 isReachanle 프로퍼티를 사용해서 시계 앱이 설치되어 있는지 또는 현재 시계에 연결할 수 있는지를 확인
                --> 워치에서 앱 실행하고 Update 버튼을 누르면 No -> Yes로 변함
                --> 워치 홈 화면으로 나가고 Update 버튼을 누르면 다시 Yes -> No로 변함
             */
            Button {
                if self.model.session.isReachable {
                    self.reachable = "Yes"
                }
                else {
                    self.reachable = "No"
                }
            } label: {
                Text("Update")
            }
            
            //밑에 처럼 그냥 불러오기만 하면 됨
            Text("receive from watch cal: \(model.burningCalories)")
            Text("receive from watch time: \(model.workOutTime)")
            Text("receive from watch date: \(model.workOutDate ?? Date())")

        }
    }
}

struct TestPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        TestPhoneView()
    }
}
