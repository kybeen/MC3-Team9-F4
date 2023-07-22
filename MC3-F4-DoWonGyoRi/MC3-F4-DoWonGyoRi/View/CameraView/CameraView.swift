//
//  CameraView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var viewModel = CameraViewModel()

    var body: some View {
        ZStack {
            viewModel.cameraPreview.ignoresSafeArea()
                .onAppear {
                    viewModel.configure()
                }
                .gesture(MagnificationGesture()
                    .onChanged { val in
                        viewModel.zoom(factor: val)
                    }
                    .onEnded { _ in
                        viewModel.zoomInitialize()
                    }
                )
            
            VStack {
                HStack {
                    // 셔터사운드 온오프
                    Button(action: {viewModel.switchFlash()}) {
                        Image(systemName: viewModel.isFlashOn ?
                              "speaker.fill" : "speaker")
                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                    
                    // 플래시 온오프
                    Button(action: {viewModel.switchSilent()}) {
                        Image(systemName: viewModel.isSilentModeOn ?
                              "bolt.fill" : "bolt")
                            .foregroundColor(viewModel.isSilentModeOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                }
                .font(.system(size:25))
                .padding()
                
                Spacer()
                
                HStack{
                    // 찍은 사진 미리보기
                    Button(action: {}) {
                        if let previewImage = viewModel.recentImage {
                            Image(uiImage: previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        } else {
                            // ✅ linewidth 살짝 수정
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75)
                        }
                    }
                    
                    Spacer()
                    
                    // 사진찍기 버튼
                    Button(action: {viewModel.capturePhoto()}) {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                    }
                    .frame(width: 75, height: 75)
                    .padding()
                }
            }
            .foregroundColor(.white)
        }
        .opacity(viewModel.shutterEffect ? 0 : 1)
    }
}

struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait

        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}


extension UIImage {
    // 워터마크 오버레이 헬퍼 함수
    func overlayWith(image: UIImage) -> UIImage {
        let newSize = CGSize(width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        image.draw(in: CGRect(origin: CGPoint(x: size.width - 200, y: size.height - 100), size: image.size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
