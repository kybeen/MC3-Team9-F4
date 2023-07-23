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
                    HStack(spacing: 0) {
                        Image(systemName: "timer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.trailing, 10)
                        Text("\(Int(workoutDataModel.todayChartDatum[8] / 60))'\(Int(workoutDataModel.todayChartDatum[8]) % 60)'")
                            .font(.custom("Inter-Black", size: 40))
                            .foregroundColor(Color.theme.teWhite)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                
                
                HStack(spacing: 0) {
                    Spacer()
                    // 플래시 온오프
                    Button(action: {viewModel.switchFlash()}) {
                        Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                            
                    }
                    .frame(width: 30, height: 30)
                    // 사진찍기 버튼
                    Button(action: {viewModel.capturePhoto()}) {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                    }
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 30, height: 30)
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
                Image(uiImage: recentImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showPreview = false
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



