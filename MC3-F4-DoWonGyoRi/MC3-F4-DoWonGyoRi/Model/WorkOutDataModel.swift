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
        calTodayChartData()
    }
    
    @Published var id = 0
    @Published var burningCalories = 0
    @Published var isBackhand = false
    @Published var perfectSwingCount = 0
    @Published var totalSwingCount = 0
    @Published var workoutDate = Date()
    @Published var workoutTime = 0
    @Published var todayWorkoutDatum: [WorkOutData] = []
    @Published var yesterdayWorkoutDatum: [WorkOutData] = []
    @Published var todayChartDatum: [Double] = []
    
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
    
    func fetchTodayAndYesterdayWorkout() {
        let entityName = "WorkOutData"
        
        // Get today's date
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Create a predicate to filter by workoutDate
        let todayPredicate = NSPredicate(format: "workoutDate >= %@", today as NSDate)
        let yesterdayPredicate = NSPredicate(format: "workoutDate < %@", today as NSDate)
        
        let todayFetchResult = coreDataManager.fetch(entityName: entityName, predicate: todayPredicate)
        let yesterdayFetchResult = coreDataManager.fetch(entityName: entityName, predicate: yesterdayPredicate)
        
        guard let todayWorkoutData = todayFetchResult as? [WorkOutData] else {
            print("No workout data found for today")
            return
        }
        
        todayWorkoutDatum = todayWorkoutData
        
        if let yesterdayWorkoutData = yesterdayFetchResult as? [WorkOutData], let latestWorkout = yesterdayWorkoutData.max(by: { $0.workoutDate ?? Date() < $1.workoutDate ?? Date() }) {
            let latestDate = calendar.startOfDay(for: latestWorkout.workoutDate ?? Date())
            if latestDate == today {
                yesterdayWorkoutDatum = yesterdayWorkoutData
                print("latestDate if문 내부 어제 데이터 : ", yesterdayWorkoutDatum)
            } else {
                yesterdayWorkoutDatum = yesterdayWorkoutData
                print("latestDate else문 내부 어제 데이터 : ", yesterdayWorkoutDatum)
            }
        } else {
            print("No workout data found for yesterday")
        }
        print("yesterdayWorkoutData if문 외부 어제 데이터 : ", yesterdayWorkoutDatum)
    }


    
    /**
     isToday 파라미터 기본값은 true, false로 하면 직전일의 데이터를 불러온다.
     return 되는 배열의 인덱스별 데이터는 아래와 같다.
     
         
         0 : 오늘의 포핸드 총 퍼펙트 스트로크 수
         1 : 어제의 포핸드 총 퍼펙트 스트로크 수
         2 : 어제 대비 오늘의 포핸드 퍼펙트 스트로크 수 차이
         3 : 오늘의 백핸드 총 퍼펙트 스트로크 수
         4 : 어제의 백핸드 총 퍼펙트 스트로크 수
         5 : 어제 대비 오늘의 포핸드 퍼펙트 스트로크 수 차이
         6 : 오늘의 총 스트로크 수
         7 : 오늘의 총 스트로크 대비 오늘의 총 퍼펙트 스트로크 비율
         8 : 어제 운동시간(분)
         9 : 오늘 운동시간(분)
         10 : 어제 대비 오늘의 운동시간 차이(분)
     */
    func calTodayChartData() {
        fetchTodayAndYesterdayWorkout()
        let todayWorkoutData = todayWorkoutDatum
        let yesterdayWorkoutData =  yesterdayWorkoutDatum
        var todayBackhandStroke = 0
        var todayBackhandPerfectStroke = 0
        var todayForehandStroke = 0
        var todayForehandPerfectStroke = 0
        var yesterdayBackhandStroke = 0
        var yesterdayBackhandPerfectStroke = 0
        var yesterdayForehandStroke = 0
        var yesterdayForehandPerfectStroke = 0
        var todayPlayTime = 0
        var yesterdayPlayTime = 0
        var todayCalories = 0
        var returnArray: [Double] = []
        
        for i in todayWorkoutData {
            if i.isBackhand {
                todayBackhandStroke += Int(i.totalSwingCount)
                todayBackhandPerfectStroke += Int(i.perfectSwingCount)
            } else {
                todayForehandStroke += Int(i.totalSwingCount)
                todayForehandPerfectStroke += Int(i.perfectSwingCount)
            }
            todayPlayTime += Int(i.workoutTime)
            todayCalories += Int(i.burningCalories)
        }
        
        for i in yesterdayWorkoutData {
            if i.isBackhand {
                yesterdayBackhandStroke += Int(i.totalSwingCount)
                yesterdayBackhandPerfectStroke += Int(i.perfectSwingCount)
            } else {
                yesterdayForehandStroke += Int(i.totalSwingCount)
                yesterdayForehandPerfectStroke += Int(i.perfectSwingCount)
            }
            
            yesterdayPlayTime += Int(i.workoutTime)
        }
        
        returnArray.append(Double(todayForehandPerfectStroke))
        returnArray.append(Double(yesterdayForehandPerfectStroke))
        returnArray.append(returnArray[0] - returnArray[1])
        returnArray.append(Double(todayBackhandPerfectStroke))
        returnArray.append(Double(yesterdayBackhandPerfectStroke))
        returnArray.append(returnArray[3] - returnArray[4])
        returnArray.append(Double(todayForehandStroke + todayBackhandStroke))
        returnArray.append((returnArray[6] == 0 ? 0 : returnArray[0] + returnArray[3]) / (returnArray[6] == 0 ? 1 : returnArray[6]))
        returnArray.append(Double(todayPlayTime))
        returnArray.append(Double(yesterdayPlayTime))
        returnArray.append(returnArray[8] - returnArray[9])
        returnArray.append(Double(todayCalories))
        print("index : 6번", returnArray[6])
        print("index : 7번", returnArray[7])
        todayChartDatum = returnArray
    }
    
    
    func createSampleWorkOutData() {
        // 새로운 WorkOutData 객체를 생성
        guard let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData else {
            print("Failed to create WorkOutData object")
            return
        }
        
        // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
        newWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
        newWorkOutData.isBackhand = Bool.random()
        newWorkOutData.perfectSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.totalSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.workoutDate = Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
        newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
        
        // 저장
        coreDataManager.update(object: newWorkOutData)
    }
    
    func createTodaySampleWorkOutData() {
        let coreDataManager = CoreDataManager.shared

        // 새로운 WorkOutData 객체를 생성
        guard let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData else {
            print("Failed to create WorkOutData object")
            return
        }
        
        // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
        newWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
        newWorkOutData.isBackhand = Bool.random()
        newWorkOutData.perfectSwingCount = Int16(Int.random(in: 10...100))
        newWorkOutData.totalSwingCount = Int16(Int.random(in: 10...200))
        newWorkOutData.workoutDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
        newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
        
        // 저장
        coreDataManager.update(object: newWorkOutData)
    }
}
