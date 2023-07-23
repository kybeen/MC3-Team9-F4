//
//  CameraViewModel.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/23.
//

import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
    private let model: CameraModel
    private let session: AVCaptureSession
    let cameraPreview: AnyView
    private var subscriptions = Set<AnyCancellable>()
    @Published var recentImage: UIImage?
    @Published var isFlashOn = false
    @Published var isSilentModeOn = false
    private var isCameraBusy = false
    let hapticImpact = UIImpactFeedbackGenerator()
    @Published var shutterEffect = false
    var currentZoomFactor: CGFloat = 1.0
    var lastScale: CGFloat = 1.0
    
    @Published var overlayText1: String = "Hello"
    @Published var overlayText2: String = "World"
    @Published var overlayFont: UIFont = UIFont.systemFont(ofSize: 24)
    @Published var overlayTextColor: UIColor = .white
    @Published private var isCameraInitialized = false
    @Published var showPreview = false
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        model.flashMode = isFlashOn == true ? .on : .off
    }
    
    func capturePhoto() {
        guard session.isRunning else {
            print("Camera session is not running.")
            return
        }
        
        if isCameraBusy == false {
            hapticImpact.impactOccurred()
            withAnimation(.easeInOut(duration: 0.1)) {
                shutterEffect = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.shutterEffect = false
                }
            }
            DispatchQueue.global().async { [self] in // 백그라운드 스레드에서 실행
                model.capturePhoto()
                print("[CameraViewModel]: Photo captured!")
                model.savePhoto()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   
                        self.showPreview = true // 메인 스레드에서 showPreview를 true로 변경
                   
                }
            }
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
    }
    
    
    // onChange에 호출하는 줌 기능
    func zoom(factor: CGFloat) {
        let delta = factor / lastScale
        lastScale = factor
        
        let newScale = min(max(currentZoomFactor * delta, 1), 5)
        model.zoom(newScale)
        currentZoomFactor = newScale
    }
    
    // onEnded에 호출하는 줌 기능
    func zoomInitialize() {
        lastScale = 1.0
    }
    
    // 전후면 카메라 스위칭
    func changeCamera() {
        model.changeCamera()
        print("[CameraViewModel]: Camera changed!")
    }
    
    private func initializeCamera() {
        DispatchQueue.main.async { [weak self] in
            self?.model.setUpCamera { success in
                if success {
                    // 카메라 초기화가 완료되면 해당 플래그를 true로 설정
                    self?.isCameraInitialized = true
                } else {
                    // 카메라 초기화가 실패한 경우의 처리를 여기에 추가합니다.
                    print("카메라 초기화 실패")
                }
            }
        }
    }

    init() {
        model = CameraModel()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))

        model.$isCameraBusy.sink { [weak self] (result) in
            self?.isCameraBusy = result
        }
        .store(in: &self.subscriptions)
        
        model.$recentImage
            .receive(on: DispatchQueue.main) // 메인 스레드에서 처리하도록 추가
            .sink { [weak self] (photo) in
                guard let pic = photo else { return }
                self?.recentImage = pic
            }
            .store(in: &self.subscriptions)
        // 아래 코드 추가
        initializeCamera()
    }
}
