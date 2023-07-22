//
//  CameraModel.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/23.
//

import Foundation
import AVFoundation
import UIKit

class CameraModel: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    var photoData = Data(count: 0)
    @Published var recentImage: UIImage?
    @Published var isCameraBusy = false
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
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
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
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
    
    // 사진 저장하기
    func savePhoto(_ imageData: Data) {
        guard let watermark = UIImage(named: "watermark") else { print("사진을 로드하지 못함"); return }
        guard let image = UIImage(data: imageData) else { return }
        let newImage = image.overlayWith(image: watermark ?? UIImage())
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("[Camera]: Photo's saved")
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
        let overlaidImage = self.recentImage?.overlayWith(image: watermark) ?? UIImage()
        
        // 오버레이된 이미지를 저장
        UIImageWriteToSavedPhotosAlbum(overlaidImage, nil, nil, nil)
        print("[CameraModel]: Photo's saved with overlay")
        
        self.isCameraBusy = false
    }
}
extension UIImage {
    func overlayWith(image: UIImage) -> UIImage {
        // Calculate the new size for the overlay image based on the original image's size and scale
        let newSize = CGSize(width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        // Draw the original image at its original position
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        // Calculate the position to overlay the watermark image at the top right corner
        let watermarkSize = CGSize(width: image.size.width / scale, height: image.size.height / scale)
        let overlayPosition = CGPoint(x: size.width - watermarkSize.width - 50, y: 320)
        
        // Draw the watermark image at the calculated position
        image.draw(in: CGRect(origin: overlayPosition, size: watermarkSize))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

//extension UIImage {
//    // 워터마크 오버레이 헬퍼 함수
//    func overlayWith(image: UIImage) -> UIImage {
//        let newSize = CGSize(width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//
//        draw(in: CGRect(origin: CGPoint.zero, size: size))
//        image.draw(in: CGRect(origin: CGPoint(x: UIScreen.main.bounds.width - 200, y: UIScreen.main.bounds.height - 100), size: image.size))
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }
//}
