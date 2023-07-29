//
//  WorkoutManager.swift
//  MC3_Tering_Watch Watch App
//
//  Created by 김영빈 on 2023/07/29.
//

import Foundation
import HealthKit
import SwiftUI

class WorkoutManager: NSObject, ObservableObject {
    @StateObject var tennisClassifierViewModel = TennisClassifierViewModel.shared
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    //MARK: - Workout 세션 시작
    func startWorkout() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .tennis
        configuration.locationType = .outdoor
        
        // Workout Session 생성
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
            print("세션 생성 완료")
        } catch {
            return
        }
        
        // Worktout data source 지정
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        // 클래스 자기 자신을 델리게이트로 지정
        session?.delegate = self
        builder?.delegate = self
        
        // Workout session 시작 + 데이터 수집 시작
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            if success {
                print("Workout session이 정상적으로 시작되었습니다!!!")
            } else {
                print("Workout session 시작 에러: \(error.debugDescription)")
            }
        }
        tennisClassifierViewModel.startMotionTracking() // 동작 분류 모델 불러오고 Device Motion 감지 시작
    }
    
    //MARK: - HealthKit 권한 요청 함수
    func requestAuthorization() {
        let typesToShare: Set = [HKQuantityType.workoutType()]
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!, // 심박수
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!, // 소모 칼로리
            HKObjectType.activitySummaryType() // 액티비티링 summary 권한
        ]
        
        // 위에서 정의한 quantity 타입들에 대해 권한 요청
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if error != nil {
                print("권한 요청 오류: \(error?.localizedDescription)")
            } else {
                if success {
                    print("권한이 허락되었습니다!!!")
                } else {
                    print("권한이 아직 없습니다.")
                }
            }
//            for type in typesToShare {
//                print("\(type)권한 상태 확인 -> Share: \(self.healthStore.authorizationStatus(for: type))")
//            }
//            for type in typesToRead {
//                print("\(type)권한 상태 확인 -> Share: \(self.healthStore.authorizationStatus(for: type))")
//            }
        }
    }
    
    //MARK: - State Control
    // workout 세션의 상태에 따른 일시정지, 재개, 종료 처리
    @Published var running = false // workout 세션이 활성화 중인지 여부
    
    // 일시정지
    func pause() {
        session?.pause()
        tennisClassifierViewModel.stopMotionTracking() // Device motion 감지 중단
    }
    // 재개
    func resume() {
        session?.resume()
        tennisClassifierViewModel.startMotionTracking() // Device motion 감지 다시 시작
    }
    // 일시정지-재개 전환
    func togglePause() {
        if running == true {
            pause()
        } else {
            resume()
        }
    }
    // Workout 세션 종료
    func endWorkout() {
        tennisClassifierViewModel.stopMotionTracking() // Device motion 감지 중단
        session?.end()
        print("세션이 종료되었습니다. \(session?.state.rawValue)")
    }
    
    //MARK: - Workout Metrics
    @Published var averageHeartRate: Double = 0 // 평균 심박수 (결과 화면 확인용)
    @Published var heartRate: Double = 0 // 실시간 심박수
    @Published var activeEnergy: Double = 0 // 소모 칼로리
    @Published var workout: HKWorkout? // Workout 데이터
    
    //MARK: - Workout 세션 진행 중 값 업데이트 해주는 함수
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            // quantity 타입에 따라 해당 값을 업데이트
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute()) // 분 단위 심박수 받기
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            default:
                return
            }
        }
    }
    
    //MARK: - 운동 세션 종료 시 Workout 정보 초기화 함수
    func resetWorkout() {
        builder = nil
        session = nil
        workout = nil
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
    }
}

//MARK: - HKWorkoutSessionDelegate
// Workout 세션 도중 이벤트 처리 관련 델리게이트 메서드
extension WorkoutManager: HKWorkoutSessionDelegate {
    // workout 세션의 state가 변할 때 호출되는 메서드
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        // 인자로 받은 toState값이 running인지 여부에 따라 running 변수 업데이트
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        
        // Workout 세션 상태 == 종료 시
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                // workout 샘플 수집 중단
                self.builder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async {
                        self.workout = workout // 운동 종료 시 workout 데이터 저장
                        print("workout 저장: \(workout) -> \(self.workout)")
                    }
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
    }
}

//MARK: - HKLiveWorkoutBuilderDelegate
// workout 데이터 추적 델리게이트
extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    // builder가 이벤트를 수집할 때마다 호출되는 메서드
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }
    
    // builder가 새로운 샘플을 수집할 때마다 호출되는 메서드
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            // 수집된 샘플의 타입이 HKQuantityType 타입인지 확인
            guard let quantityType = type as? HKQuantityType else { return }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            // @Published 값들 업데이트
            updateForStatistics(statistics)
        }
    }
}