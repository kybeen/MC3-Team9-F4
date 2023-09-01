//
//  TennisClassifierViewModel.swift
//  MC3_Tering_Watch Watch App
//
//  Created by 김영빈 on 2023/07/26.
//

import CoreML
import CoreMotion
import Foundation
import SwiftUI

// MARK: - 테니스 동작 분류 모델 관련 클래스
class TennisClassifierViewModel: ObservableObject {
    static let shared = TennisClassifierViewModel() // 싱글톤 인스턴스
    // 외부에서 인스턴스를 생성하지 못하도록 private init로 선언
    private init() {
        // 모델 불러오기
        guard let modelURL = Bundle.main.url(forResource: self.MODEL_NAME, withExtension: "mlmodelc") else {
            fatalError("Failed to locate the model file.")
        }
        guard let model = try? TeringClassifier_totalData_window100(contentsOf: modelURL) else {
            fatalError("Failed to create the model.")
        }
        mlModel = model
        print("🤖모델 불러오기 성공!!! : \(mlModel)")
    }
    
    @Published var isDetecting = false // device motion 추적 중인지
    let motionManager = CMMotionManager()
    
    let MODEL_NAME = "TeringClassifier_totalData_window100"
    let WINDOW_SIZE = 100 // 슬라이딩 윈도우
    let PRE_BUFFER_SIZE = 30 // 스윙 감지 전 미리 채워놓을 버퍼 사이즈 (100->30 / 200->70)
    let FREQUENCY = 50 // 데이터 빈도수
    let THRESHOLD: Double = 0.8 // Perfect-Bad 기준 probability
    @Published var classLabel: String = "?" // 동작 분류 결과
    @Published var resultLabel: String = "?" // Perfect-Bad 결과
    @Published var confidence: String = "0.0" // 분류 Confidence
    
    @Published var forehandPerfectCount: Int = 0 // 포핸드 perfect 스윙 횟수
    @Published var forehandBadCount: Int = 0 // 포핸드 bad 스윙 횟수
    @Published var backhandPerfectCount: Int = 0 // 백핸드 perfect 스윙 횟수
    @Published var backhandBadCount: Int = 0 // 백핸드 bad 스윙 횟수
    @Published var totalCount: Int = 0 // 전체 스윙 횟수
    @Published var timestamp: Double = 0.0
    @Published var isSwing = false // 스윙 중인지 체크
    
    // MARK: isSwing 바인딩용 프로퍼티
    var isSwingBinding: Binding<Bool> {
        Binding<Bool>(
            get: { self.isSwing },
            set: { newValue in
                self.isSwing = newValue
            }
        )
    }
    // 모델 인풋용 윈도우 버퍼
    var bufferAccX: [Double] = []
    var bufferAccY: [Double] = []
    var bufferAccZ: [Double] = []
    var bufferRotX: [Double] = []
    var bufferRotY: [Double] = []
    var bufferRotZ: [Double] = []
    
    var mlModel: TeringClassifier_totalData_window100
    
    // MARK: - 감지 시작
    func startMotionTracking() {
        self.isDetecting = true
//        // 모델 불러오기
//        guard let modelURL = Bundle.main.url(forResource: self.MODEL_NAME, withExtension: "mlmodelc") else {
//            fatalError("Failed to locate the model file.")
//        }
//        guard let model = try? TeringClassifier_totalData_window100(contentsOf: modelURL) else {
//            fatalError("Failed to create the model.")
//        }
//        print("모델 불러오기 성공!!! : \(model)")
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion service is not available.")
            return
        }
        var startTime: TimeInterval = 0.0 // 시작 시간 저장 변수
        let updateInterval = 1.0 / Double(FREQUENCY)
        motionManager.deviceMotionUpdateInterval = updateInterval // 센서 데이터 빈도수 설정
        print("모셩 갱신 주기 설정 : \(FREQUENCY)Hz -> \(motionManager.deviceMotionUpdateInterval)")
        motionManager.startDeviceMotionUpdates(to: .main) { (deviceMotion, error) in
            guard let deviceMotionData = deviceMotion, error==nil else {
                print("Failed to get device motion data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if startTime == 0.0 {
                startTime = deviceMotionData.timestamp // 첫 번째 데이터의 타임스탬프 저장
            }
            let timestamp = deviceMotionData.timestamp - startTime // 시작 시간으로부터 경과한 시간 계산
            self.timestamp = timestamp
            
            // PRE_BUFFER_SIZE 크기만큼 버퍼 세팅이 안돼있으면 채워준다.
            if self.bufferRotZ.count < self.PRE_BUFFER_SIZE {
                self.bufferAccX.append(deviceMotionData.userAcceleration.x)
                self.bufferAccY.append(deviceMotionData.userAcceleration.y)
                self.bufferAccZ.append(deviceMotionData.userAcceleration.z)
                self.bufferRotX.append(deviceMotionData.rotationRate.x)
                self.bufferRotY.append(deviceMotionData.rotationRate.y)
                self.bufferRotZ.append(deviceMotionData.rotationRate.z)
            }
            else { // PRE_BUFFER_SIZE 크기만큼 버퍼 세팅이 완료되었으면
                if self.isSwing == false {
                    // 스윙이 감지되면 isSwing 값을 바꿔준다.
                    if self.detectSwing(type: "Forehand", accX: deviceMotionData.userAcceleration.x, accY: deviceMotionData.userAcceleration.y, accZ: deviceMotionData.userAcceleration.z) {
                        print("스윙 감지!!! 예측 수행 시작")
                        self.isSwing = true
                    }
                    else { // 스윙이 감지되지 않으면 버퍼 맨 앞을 제거하여 한 칸씩 조정
                        self.bufferAccX.removeFirst()
                        self.bufferAccY.removeFirst()
                        self.bufferAccZ.removeFirst()
                        self.bufferRotX.removeFirst()
                        self.bufferRotY.removeFirst()
                        self.bufferRotZ.removeFirst()
                    }
                } else { // isSwing == true 일 때
                    // 버퍼 길이가 WINDOW_SIZE에 도달하면 인풋을 만들고 예측을 수행
                    if self.bufferRotZ.count >= self.WINDOW_SIZE {
                        // 입력값 준비
                        let startIndex = 0
                        let endIndex = self.WINDOW_SIZE - 1
                        let MultiArrayAccX = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayAccY = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayAccZ = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayRotX = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayRotY = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayRotZ = try! MLMultiArray(shape: [NSNumber(value: self.WINDOW_SIZE)], dataType: .double)
                        let MultiArrayStateIn = try! MLMultiArray(shape: [400], dataType: .double)
                        for i in 0..<400 {
                            MultiArrayStateIn[i] = NSNumber(value: 0.0) // 배열의 각 요소를 0.0으로 초기화
                        }
                        
                        for i in startIndex..<endIndex {
                            MultiArrayAccX[i] = NSNumber(value: self.bufferAccX[i])
                            MultiArrayAccY[i] = NSNumber(value: self.bufferAccY[i])
                            MultiArrayAccZ[i] = NSNumber(value: self.bufferAccZ[i])
                            MultiArrayRotX[i] = NSNumber(value: self.bufferRotX[i])
                            MultiArrayRotY[i] = NSNumber(value: self.bufferRotY[i])
                            MultiArrayRotZ[i] = NSNumber(value: self.bufferRotZ[i])
                        }
                        let input = TeringClassifier_totalData_window100Input(
                            Acceleration_X: MultiArrayAccX,
                            Acceleration_Y: MultiArrayAccY,
                            Acceleration_Z: MultiArrayAccZ,
                            Rotation_Rate_X: MultiArrayRotX,
                            Rotation_Rate_Y: MultiArrayRotY,
                            Rotation_Rate_Z: MultiArrayRotZ,
                            stateIn: MultiArrayStateIn
                        )
                        // 예측 수행
                        guard let output = try? self.mlModel.prediction(input: input) else {
                            fatalError("Failed to predict.")
                        }
                        let label = output.label
                        let prob = output.labelProbability[output.label]!
                        self.classLabel = label
                        self.confidence = String(prob)
                        print("output.label: \(output.label), output.labelProb: \(String(prob))")
                        print("Confidence: Forehand: \(String(output.labelProbability["Forehand"]!)) || Backhand: \(String(output.labelProbability["Backhand"]!))")
                        
                        // 포핸드라면
                        if label == "Forehand" {
                            if prob >= self.THRESHOLD {
                                self.forehandPerfectCount += 1
                                self.resultLabel = "PERFECT"
                            } else {
                                self.forehandBadCount += 1
                                self.resultLabel = "BAD"
                            }
                        } else { // 백핸드라면
                            if prob >= self.THRESHOLD {
                                self.backhandPerfectCount += 1
                                self.resultLabel = "PERFECT"
                            } else {
                                self.backhandBadCount += 1
                                self.resultLabel = "BAD"
                            }
                        }
                        self.totalCount += 1
                        
                        // 예측 수행 뒤 버퍼 초기화
                        self.bufferAccX = []
                        self.bufferAccY = []
                        self.bufferAccZ = []
                        self.bufferRotX = []
                        self.bufferRotY = []
                        self.bufferRotZ = []
                        self.isSwing = false // isSwing도 다시 false로 돌려놓는다.
                    }
                    else { // 버퍼 길이가 WINDOW_SIZE보다 작으면 계속 채워준다.
                        self.bufferAccX.append(deviceMotionData.userAcceleration.x)
                        self.bufferAccY.append(deviceMotionData.userAcceleration.y)
                        self.bufferAccZ.append(deviceMotionData.userAcceleration.z)
                        self.bufferRotX.append(deviceMotionData.rotationRate.x)
                        self.bufferRotY.append(deviceMotionData.rotationRate.y)
                        self.bufferRotZ.append(deviceMotionData.rotationRate.z)
                    }
                }
            }
        }
    }
    
    // MARK: - 스윙 측정 중 감지 일시정지
    func pauseMotionTracking() {
        motionManager.stopDeviceMotionUpdates()
        // 버퍼 초기화
        self.bufferAccX = []
        self.bufferAccY = []
        self.bufferAccZ = []
        self.bufferRotX = []
        self.bufferRotY = []
        self.bufferRotZ = []
        print("👉 모션 트래킹 일시정지")
    }
    
    // MARK: - 감지 종료
    func stopMotionTracking() {
        motionManager.stopDeviceMotionUpdates()
        // 버퍼 초기화
        self.bufferAccX = []
        self.bufferAccY = []
        self.bufferAccZ = []
        self.bufferRotX = []
        self.bufferRotY = []
        self.bufferRotZ = []
        print("버퍼 초기화 \(self.bufferAccX), \(self.bufferAccY), \(self.bufferAccZ), \(self.bufferRotX), \(self.bufferRotY), \(self.bufferRotZ)")
        self.isDetecting = false
    }
    
    // MARK: 스윙 감지 알고리즘
    func detectSwing(type: String, accX: Double, accY: Double, accZ: Double) -> Bool {
        let sumOfAbsAcc = abs(accX) + abs(accY) + abs(accZ)
        let subOfAccXZ = accX + accZ
        // 포핸드 기준
        if sumOfAbsAcc >= 6.0 && abs(accX) >= 3.0 && abs(accZ) >= 2.5 && abs(subOfAccXZ) <= 2.0 {
//            print("============================================================")
//            print("Acc 스칼라 합: \(sumOfAbsAcc)")
//            print("AccX와 AccZ의 합: \(subOfAccXZ)")
//            print("AccX: \(accX), AccY: \(accY), AccZ: \(accZ)")
//            print("============================================================")
            return true
        } else {
            //TODO: 백핸드도 데이터 확인 후 식 짜기
            return false
        }
    }
}
