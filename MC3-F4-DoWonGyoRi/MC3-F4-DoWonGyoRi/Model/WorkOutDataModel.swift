//
//  WorkOutDataModel.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/17.
//

import Foundation

class WorkOutDataModel: ObservableObject {
    static let shared = WorkOutDataModel()
    private init() {
        fetchWorkOutData()
    }
    
    @Published var id = 0
    @Published var burningCalories = 0
    @Published var isBackhand = false
    @Published var perfectSwingCount = 0
    @Published var totalSwingCount = 0
    @Published var workoutDate = Date()
    @Published var workoutTime = 0
    @Published var todayWorkoutDatum: [WorkOutData] = []
    
    private let coreDataManager = CoreDataManager.shared
    
    func fetchWorkOutData() {
        let entityName = "WorkOutData"
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let workoutData = fetchResult.first as? WorkOutData else {
            print("Failed to fetch UserData")
            return
        }
        
    }
    
    func createWorkOutData() {
        let entityName = "WorkOutData"
        if let newWorkOutData = coreDataManager.create(entityName: entityName, attributes: [:]) as? WorkOutData {
            
            // 새로운 WorkOutData를 현재 작업 대상으로 설정
            let fetchResult = coreDataManager.fetch(entityName: entityName)
            if let currentWorkOutData = fetchResult.first as? WorkOutData {
                currentWorkOutData.id = Int16(id)
                currentWorkOutData.burningCalories = Int16(burningCalories)
                currentWorkOutData.isBackhand = isBackhand
                currentWorkOutData.perfectSwingCount = Int16(perfectSwingCount)
                currentWorkOutData.totalSwingCount = Int16(totalSwingCount)
                currentWorkOutData.workoutDate = workoutDate
                currentWorkOutData.workoutTime = Int16(workoutTime)
            }
            
            coreDataManager.update(object: newWorkOutData)
        }
    }
    
    func saveWorkOutData() {
        let entityName = "WorkOutData"
        var workoutData: WorkOutData?
        
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        if let existingWorkOutData = fetchResult.first as? WorkOutData {
            workoutData = existingWorkOutData
        } else if let newWorkOutData = coreDataManager.create(entityName: entityName, attributes: [:]) as? WorkOutData {
            workoutData = newWorkOutData
        }
        
        guard let workout = workoutData else {
            print("Failed to create or find UserData")
            return
        }
        
        workout.id = Int16(id)
        workout.burningCalories = Int16(burningCalories)
        workout.isBackhand = isBackhand
        workout.perfectSwingCount = Int16(perfectSwingCount)
        workout.totalSwingCount = Int16(totalSwingCount)
        workout.workoutDate = workoutDate
        workout.workoutTime = Int16(workoutTime)
        
        coreDataManager.update(object: workout)
    }
    
    func fetchTodayWorkout() {
        let entityName = "WorkOutData"
        
        // Get today's date
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Create a predicate to filter by workoutDate
        let predicate = NSPredicate(format: "workoutDate == %@", today as NSDate)
        
        let fetchResult = coreDataManager.fetch(entityName: entityName, predicate: predicate)
        
        guard let workoutData = fetchResult as? [WorkOutData] else {
            print("No workout data found for today")
            return
        }
        
        todayWorkoutDatum = workoutData
    }
    
}
