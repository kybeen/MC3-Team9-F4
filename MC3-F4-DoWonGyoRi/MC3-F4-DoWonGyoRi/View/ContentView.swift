//
//  ContentView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by KimTaeHyung on 2023/07/07.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("_isFirstLaunch") var isFirst: Bool = true
    
    var body: some View {
        if isFirst {
            OnboardingView(isFirst: $isFirst)
        } else {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
