//
//  WatchTestView.swift
//  MC3-F4-DoWonGyoRi Watch App
//
//  Created by 김영빈 on 2023/07/24.
//

import SwiftUI

struct WatchTestView: View {
    @ObservedObject var model = WatchViewModel()
    
    var body: some View {
        VStack {
            Text(self.model.messageText)
            Text(self.model.number)
        }
    }
}

struct WatchTestView_Previews: PreviewProvider {
    static var previews: some View {
        WatchTestView()
    }
}
