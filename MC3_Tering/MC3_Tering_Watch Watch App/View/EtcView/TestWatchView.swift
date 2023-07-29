//
//  TestWatchView.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct TestWatchView: View {
    @ObservedObject var model = ViewModelWatch()
    
    var body: some View {
        VStack {
            Text("데이터 확인")
            Text(self.model.messageText)
            Text(self.model.number)
        }
    }}

struct TestWatchView_Previews: PreviewProvider {
    static var previews: some View {
        TestWatchView()
    }
}
