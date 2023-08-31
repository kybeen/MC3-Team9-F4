//
//  MC3_Tering_WatchApp.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

@main
struct MC3_Tering_Watch_Watch_AppApp: App {
    @StateObject var workoutResultInfo = WorkoutResultInfo()
    @StateObject var swingInfo = SwingInfo()
    @StateObject var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            SwingCountView()
                .environmentObject(workoutResultInfo)
                .environmentObject(swingInfo)
                .environmentObject(workoutManager)
        }
    }
}
