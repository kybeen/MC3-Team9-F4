//
//  ContentView.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("_isFirstLaunch") var isFirst: Bool = true
    @ObservedObject var emitterManager = EmitterManager.shared
    @ObservedObject var userDataModel = UserDataModel.shared
    @ObservedObject var workoutDataModel = WorkOutDataModel.shared
    
    var body: some View {
        if isFirst {
            OnboardingView(isFirst: $isFirst)
        } else {
            ZStack {
                MainView(userDataModel: userDataModel, workoutDataModel: workoutDataModel)
                if emitterManager.isEmitterOn {
                    EmitterView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
