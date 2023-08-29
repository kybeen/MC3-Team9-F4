//
//  WorkOutDataModel.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
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
    @Published var totalSwingCount = 3
    @Published var workoutDate = Date()
    @Published var workoutTime = 0
    @Published var todayWorkoutDatum: [WorkOutData] = []
    @Published var yesterdayWorkoutDatum: [WorkOutData] = []
    @Published var todayChartDatum: [Double] = []
    @Published var forehandPerfect = 0
    @Published var forehandTotalCount = 0
    @Published var backhandPerfect = 0
    @Published var backhandTotalCount = 0
    
    var months: [String: [WorkOutData]] = [:]
    
    private let coreDataManager = CoreDataManager.shared
    
    func fetchWorkOutData() {
        let entityName = "WorkOutData"
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let workoutData = fetchResult.first as? WorkOutData else {
            print("Failed to fetch UserData")
            return
        }
        
    }
    
    func fetchPast100DaysWorkOutData() -> [WorkOutData]? {
        let entityName = "WorkOutData"
        
        // Calculate the date 100 days ago from today
        let calendar = Calendar.current
        let hundredDaysAgo = calendar.date(byAdding: .day, value: -100, to: Date()) ?? Date()
        
        // Create a predicate to filter by workoutDate
        let predicate = NSPredicate(format: "workoutDate >= %@", hundredDaysAgo as NSDate)
        
        return coreDataManager.fetch(entityName: entityName, predicate: predicate) as? [WorkOutData]
    }
    
    func fetchPast100DaysWorkoutdatabymonth() -> [String: [WorkOutData]] {
        let entityName = "WorkOutData"
        let calendar = Calendar.current
        var monthsData: [String: [WorkOutData]] = [:]
        
        if let datum = fetchPast100DaysWorkOutData() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월"
            
            for data in datum {
                if let workoutDate = data.workoutDate {
                    let yearMonth = calendar.component(.year, from: workoutDate)
                    let month = calendar.component(.month, from: workoutDate)
                    let monthKey = dateFormatter.string(from: workoutDate)
                    
                    if monthsData[monthKey] == nil {
                        monthsData[monthKey] = []
                    }
                    monthsData[monthKey]?.append(data)
                }
            }
        }
        return monthsData
    }
    
    func testCreate100Days() {
        let entityName = "WorkOutData"
        for i in stride(from: 20, to: 0, by: -1) {
            if let newWorkOutData = coreDataManager.create(entityName: entityName, attributes: [:]) as? WorkOutData {
                let newDate = Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date()
                
                // 새로운 WorkOutData를 현재 작업 대상으로 설정
                let currentWorkOutData = newWorkOutData  // 새로운 객체를 현재 작업 대상으로 설정
                
                // 각 속성 값을 설정
                currentWorkOutData.id = Int16(id)
                currentWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
                currentWorkOutData.backhandPerfect = Int16(Int.random(in: 20...60))
                currentWorkOutData.backhandTotalCount = Int16(backhandTotalCount)
                currentWorkOutData.forehandPerfect = Int16(Int.random(in: 20...60))
                currentWorkOutData.forehandTotalCount = Int16(forehandTotalCount)
                currentWorkOutData.totalSwingCount = Int16(totalSwingCount)
                currentWorkOutData.workoutDate = newDate
                currentWorkOutData.workoutTime = Int16(workoutTime)
                
                coreDataManager.update(object: currentWorkOutData)  // 수정된 객체를 저장
            }
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
                currentWorkOutData.backhandPerfect = Int16(backhandPerfect)
                currentWorkOutData.backhandTotalCount = Int16(backhandTotalCount)
                currentWorkOutData.forehandPerfect = Int16(forehandPerfect)
                currentWorkOutData.forehandTotalCount = Int16(forehandTotalCount)
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
        workout.backhandPerfect = Int16(backhandPerfect)
        workout.backhandTotalCount = Int16(backhandTotalCount)
        workout.forehandPerfect = Int16(forehandPerfect)
        workout.forehandTotalCount = Int16(forehandTotalCount)
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
//                print("latestDate if문 내부 어제 데이터 : ", yesterdayWorkoutDatum)
            } else {
                yesterdayWorkoutDatum = yesterdayWorkoutData
//                print("latestDate else문 내부 어제 데이터 : ", yesterdayWorkoutDatum)
            }
        } else {
            print("No workout data found for yesterday")
        }
//        print("yesterdayWorkoutData if문 외부 어제 데이터 : ", yesterdayWorkoutDatum)
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
            todayBackhandStroke += Int(i.backhandTotalCount)
            todayBackhandPerfectStroke += Int(i.backhandPerfect)
            todayForehandStroke += Int(i.forehandTotalCount)
            todayForehandPerfectStroke += Int(i.forehandPerfect)
            todayPlayTime += Int(i.workoutTime)
            todayCalories += Int(i.burningCalories)
        }
        
        for i in yesterdayWorkoutData {
            yesterdayBackhandStroke += Int(i.backhandTotalCount)
            yesterdayBackhandPerfectStroke += Int(i.backhandPerfect)
            yesterdayForehandStroke += Int(i.forehandTotalCount)
            yesterdayForehandPerfectStroke += Int(i.forehandPerfect)
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
    
    
    func createSampleWorkOutData(_ burningCalories: Int, _ forehandPerfect: Int, _ forehandTotalCount: Int, _ backhandPerfect: Int, _ backhandTotalCount: Int, _ totalSwingCount: Int, _ workoutDate: Date) {
        // 새로운 WorkOutData 객체를 생성
        if let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData {
            // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
            newWorkOutData.burningCalories = Int16(burningCalories)
            newWorkOutData.forehandPerfect = Int16(forehandPerfect)
            newWorkOutData.forehandTotalCount = Int16(forehandTotalCount)
            newWorkOutData.backhandPerfect = Int16(backhandPerfect)
            newWorkOutData.backhandTotalCount = Int16(backhandTotalCount)
            newWorkOutData.totalSwingCount = Int16(totalSwingCount)
            newWorkOutData.workoutDate = workoutDate
            newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
            
            // 저장
            coreDataManager.update(object: newWorkOutData)
        }
    }
    
    func createTodaySampleWorkOutData() {
        // 새로운 WorkOutData 객체를 생성
        if let newWorkOutData = coreDataManager.create(entityName: "WorkOutData", attributes: [:]) as? WorkOutData {
            // WorkOutData 엔티티의 속성을 기본값이 아닌 랜덤 값으로 설정
            newWorkOutData.burningCalories = Int16(Int.random(in: 200...500))
            newWorkOutData.forehandPerfect = Int16(Int.random(in: 10...100))
            newWorkOutData.forehandTotalCount = Int16(Int.random(in: 10...100))
            newWorkOutData.backhandPerfect = Int16(Int.random(in: 10...100))
            newWorkOutData.backhandTotalCount = Int16(Int.random(in: 10...100))
            newWorkOutData.totalSwingCount = Int16(Int.random(in: 10...200))
            newWorkOutData.workoutDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
            newWorkOutData.workoutTime = Int16(Int.random(in: 10...200))
            
            // 저장
            coreDataManager.update(object: newWorkOutData)
        }
    }
}
