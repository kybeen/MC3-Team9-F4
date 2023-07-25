//
//  CameraViewModel.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
    private let model: CameraModel
    private let workoutDataModel: WorkOutDataModel
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
    
    func shareToInstagramStories(
        backgroundTopColor: String = "#7F0909",
        backgroundBottomColor: String = "#303030") {
        // 1. Get a data object of our UIImage...
        let stickerImageData = self.recentImage?.pngData()
        
        // 2. Verify if we are able to open instagram-stories URL schema.
        // If we are able to, let's add our Sticker image to UIPasteboard.
        
        let urlScheme = URL(string: "instagram-stories://share?source_application=\(Bundle.main.bundleIdentifier ?? "")")
        
        if let urlScheme = urlScheme {
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                var pasteboardItems: [[String : Any]]? = nil
                if let stickerImageData = stickerImageData {
                    pasteboardItems = [
                        [
                            "com.instagram.sharedSticker.stickerImage": stickerImageData
                        ]
                    ]
                }
                
                // We'll expire these pasteboard items in 5 minutes...
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)
                ]
                
                if let pasteboardItems = pasteboardItems {
                    UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                }
                
                // 3. Try opening the URL...
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            } else {
                // App may not be installed. Handle those errors here...
                print("Something went wrong. Maybe Instagram is not installed on this device?")
            }
        }
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

    init(workoutDataModel: WorkOutDataModel) {
        self.workoutDataModel = workoutDataModel
        self.model = CameraModel(workoutDataModel: workoutDataModel)
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
