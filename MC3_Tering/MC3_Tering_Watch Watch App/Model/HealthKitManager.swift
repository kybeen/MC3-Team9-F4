//
//  HealthKitManager.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
    let share = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
    
    @Published var currentCalories: Double = 0.0
    @Published var caloriesHistory = [Double]()
    @Published var resultCalories: Double = 0.0     //총 칼로리
    
    func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: share, read: read) { (success, error) in
            if success {
                print("Authorization succeeded.")
            } else {
                print("Authorization failed. Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func readCurrentCalories() {
        guard let caloriesType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("칼로리 타입을 가져올 수 없습니다.")
            return
        }
        
        let now = Date()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: caloriesType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] (_, result, error) in
            guard let self = self, let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("칼로리 가져오기 오류: \(error.localizedDescription)")
                }
                return
            }
            
            let currentCalories = sum.doubleValue(for: .kilocalorie())
            DispatchQueue.main.async {
                self.currentCalories = currentCalories
                self.caloriesHistory.append(currentCalories)
            }
        }
        
        healthStore.execute(query)
    }
}
