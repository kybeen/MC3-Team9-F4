//
//  CameraModel.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

class CameraModel: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    var photoData = Data(count: 0)
    @Published var recentImage: UIImage?
    @Published var isCameraBusy = false
    var flashMode: AVCaptureDevice.FlashMode = .off
    private let workoutDataModel: WorkOutDataModel
    init(workoutDataModel: WorkOutDataModel) {
            self.workoutDataModel = workoutDataModel
            super.init()
        }
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera(completion: @escaping (Bool) -> Void) {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            do {
                // 카메라가 사용 가능하면 세션에 input과 output을 연결
                self.videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if self.session.canAddInput(self.videoDeviceInput) {
                    self.session.addInput(self.videoDeviceInput)
                }
                
                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                    self.output.isHighResolutionCaptureEnabled = true
                    self.output.maxPhotoQualityPrioritization = .quality
                }
                
                DispatchQueue.global(qos: .userInitiated).async { // 백그라운드 스레드에서 세션 시작
                    self.session.startRunning() // 세션 시작
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            } catch {
                print(error) // 에러 프린트
                
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    func requestAndCheckPermissions() {
            // 카메라 권한 상태 확인
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                // 권한 요청
                AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                    if authStatus {
                        DispatchQueue.main.async {
                            self?.setUpCamera { success in
                                if success {
                                    // Camera setup was successful
                                    // Add any additional actions that need to be performed after setup here
                                    print("Camera setup was successful.")
                                } else {
                                    // Camera setup failed
                                    // Add any actions that need to be performed in case of failure here
                                    print("Camera setup failed.")
                                }
                            }
                        }
                    }
                }
            case .restricted:
                break
            case .authorized:
                // 이미 권한 받은 경우 셋업
                setUpCamera { success in
                    if success {
                        // Camera setup was successful
                        // Add any additional actions that need to be performed after setup here
                        print("Camera setup was successful.")
                    } else {
                        // Camera setup failed
                        // Add any actions that need to be performed in case of failure here
                        print("Camera setup failed.")
                    }
                }
            default:
                // 거절했을 경우
                print("Permission declined")
            }
        }
    
    // ✅ 추가
    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    
//     사진 저장하기
    func savePhoto() {
        guard let recentImage = self.recentImage,
              let watermarkImage = UIImage(named: "watermark") else { return }
        let overlayImage = recentImage.overlayWith(image: watermarkImage, texts: ["\(Int(workoutDataModel.todayChartDatum[6])) SWING", "\(Int(workoutDataModel.todayChartDatum[7] * workoutDataModel.todayChartDatum[6])) PERFECT", "\(Int(workoutDataModel.todayChartDatum[8] / 60))h \(Int(workoutDataModel.todayChartDatum[8]) % 60)m"], textColors: [UIColor(Color.theme.teGreen), UIColor(Color.theme.teSkyBlue), UIColor.white])

        self.recentImage = recentImage
        UIImageWriteToSavedPhotosAlbum(overlayImage, nil, nil, nil)
        print("[CameraViewModel]: Photo's saved with overlay")
    }
    
    // 줌 기능
    func zoom(_ zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.videoDeviceInput.device
        
        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // 카메라 스위칭
    func changeCamera() {
        let currentPosition = self.videoDeviceInput.device.position
        let preferredPosition: AVCaptureDevice.Position
        
        switch currentPosition {
        case .unspecified, .front:
            print("후면카메라로 전환합니다.")
            preferredPosition = .back
            
        case .back:
            print("전면카메라로 전환합니다.")
            preferredPosition = .front
            
        @unknown default:
            print("알 수 없는 포지션. 후면카메라로 전환합니다.")
            preferredPosition = .back
        }
        
        if let videoDevice = AVCaptureDevice
            .default(.builtInWideAngleCamera,
                     for: .video, position: preferredPosition) {
            do {
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                self.session.beginConfiguration()
                
                if let inputs = session.inputs as? [AVCaptureDeviceInput] {
                    for input in inputs {
                        session.removeInput(input)
                    }
                }
                if self.session.canAddInput(videoDeviceInput) {
                    self.session.addInput(videoDeviceInput)
                    self.videoDeviceInput = videoDeviceInput
                } else {
                    self.session.addInput(self.videoDeviceInput)
                }
                
                if let connection =
                    self.output.connection(with: .video) {
                    if connection.isVideoStabilizationSupported {
                        connection.preferredVideoStabilizationMode = .auto
                    }
                }
                
                output.isHighResolutionCaptureEnabled = true
                output.maxPhotoQualityPrioritization = .quality
                
                self.session.commitConfiguration()
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
}

extension CameraModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.recentImage = UIImage(data: imageData)
        
        // 워터마크 이미지 로드
        guard let watermark = UIImage(named: "watermark") else {
            print("Failed to load watermark image")
            return
        }
        
        // 이미지 오버레이
        let overlaidImage = self.recentImage?.overlayWith(image: watermark, texts: ["\(Int(workoutDataModel.todayChartDatum[6])) SWING", "\(Int(workoutDataModel.todayChartDatum[7] * workoutDataModel.todayChartDatum[6])) PERFECT", "\(Int(workoutDataModel.todayChartDatum[8] / 60))h \(Int(workoutDataModel.todayChartDatum[8]) % 60)m"], textColors: [UIColor(Color.theme.teGreen), UIColor(Color.theme.teSkyBlue), UIColor.white]) ?? UIImage()
        self.recentImage = overlaidImage
        // 오버레이된 이미지를 저장
        UIImageWriteToSavedPhotosAlbum(overlaidImage, nil, nil, nil)
        print("[CameraModel]: Photo's saved with overlay")
        // 최근 이미지가 설정되었음을 알립니다.
        self.isCameraBusy = false
    }
}

extension UIImage {
    func overlayWith(image overlayImage: UIImage, texts: [String], textColors: [UIColor]) -> UIImage {
        let newSize = CGSize(width: size.width, height: size.height)
        let overlayImageSize = CGSize(width: 100, height: 100)
        let overlayImageOrigin = CGPoint(x: size.width - overlayImageSize.width - 100, y: 100)
        let totalTextHeight = texts.reduce(0) { $0 + ($1.size(withAttributes: [.font: UIFont(name: "Inter-Bold", size: 100)!]).height) + 10 }
        var offsetY: CGFloat = size.height - totalTextHeight - 100 // 초기 Y 좌표 값 설정 (텍스트가 맨 하단에 오버레이될 위치)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        overlayImage.draw(in: CGRect(origin: overlayImageOrigin, size: overlayImageSize))
        
        for (index, text) in texts.enumerated() {
            
            let textColor = textColors[index]
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Inter-Black", size: 100)!,
                .foregroundColor: textColor,
                .paragraphStyle: paragraphStyle
            ]
            
            let textSize = text.size(withAttributes: textAttributes)
            let textOrigin = CGPoint(x: 100, y: offsetY) // 왼쪽 아래로 이동 (오버레이될 위치)
            let textRect = CGRect(origin: textOrigin, size: textSize)
            text.draw(in: textRect, withAttributes: textAttributes)
            
            offsetY += (textSize.height + 5) // 다음 텍스트를 그리기 위해 Y 좌표 값 조정
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
