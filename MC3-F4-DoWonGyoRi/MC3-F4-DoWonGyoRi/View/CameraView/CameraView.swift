//
//  CameraView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel
    @ObservedObject var workoutDataModel: WorkOutDataModel
    
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
                HStack(spacing: 0) {
                    Spacer()
                    Image("watermark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 50)
                }
                Spacer()
                VStack(spacing: 0) {
                    Text("\(Int(workoutDataModel.todayChartDatum[6])) SWING")
                        .font(.custom("Inter-Black", size: 40))
                        .foregroundColor(Color.theme.teGreen)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(Int(workoutDataModel.todayChartDatum[7] * workoutDataModel.todayChartDatum[6])) PERFECT")
                        .font(.custom("Inter-Black", size: 40))
                        .foregroundColor(Color.theme.teSkyBlue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(Int(workoutDataModel.todayChartDatum[8] / 60))h \(Int(workoutDataModel.todayChartDatum[8]) % 60)m")
                        .font(.custom("Inter-Black", size: 40))
                        .foregroundColor(Color.theme.teWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                
                
                HStack(spacing: 0) {
                    Spacer()
                    // 플래시 온오프
                    Button(action: {viewModel.switchFlash()}) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.theme.teRealBlack.opacity(0.3))
                                .cornerRadius(100)
                            Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 30)
                    // 사진찍기 버튼
                    Button(action: {viewModel.capturePhoto()}) {
                        Circle()
                            .stroke(lineWidth: 10)
                            .frame(maxWidth: 75, maxHeight: 75)
                            .foregroundColor(Color.theme.teGreen)
                            .background(Color.theme.teBlack)
                            .cornerRadius(100)
                    }
                    .frame(maxWidth: 75, maxHeight: 75)
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.theme.teRealBlack.opacity(0.3))
                                .cornerRadius(100)
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .padding(.leading, 30)
                    Spacer()
                }
            }
            .foregroundColor(.white)
        }
        .opacity(viewModel.shutterEffect ? 0 : 1)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: CustomBackButton())
        .fullScreenCover(isPresented: $viewModel.showPreview) {
            if let recentImage = viewModel.recentImage {
                VStack {
                    HStack(spacing: 0) {
                        Spacer()
                        Button(action: {
                            viewModel.showPreview = false
                            // TODO: - 최근 사진 1개 삭제 기능 추가
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(Color.theme.teGreen)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 20)
                    .padding(.trailing, 20)
                    .padding(.vertical, 20)
                    Image(uiImage: recentImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    HStack(spacing: 0) {
                        Button(action: {
                            viewModel.showPreview = false
                        }) {
                            Text("저장")
                                .font(.custom("Inter-SemiBold", size: 20))
                                .foregroundColor(Color.theme.teBlue)
                        }
                        .frame(width: UIScreen.main.bounds.width / 2, height: 50)
                        
                        Button(action: {
                            // TODO: - 인스타그램 스토리 딥링크 연결
                        }) {
                            Text("공유하기")
                                .font(.custom("Inter-SemiBold", size: 20))
                                .foregroundColor(Color.theme.teGreen)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width / 2, height: 50)
                        
                    }
                    .padding(.bottom, 16)
                    
                }
            } else {
                // recentImage가 없을 경우 미리보기를 표시하지 않음
                EmptyView()
            }
        }
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



