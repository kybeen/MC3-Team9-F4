//
//  CongreteModalView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/16.
//

import SwiftUI

struct CongreteModalView: View {
    @State private var wish = false
    @State private var finishWish = false
    
    var body: some View {
        ZStack {
            
            
            EmitterView()
                .opacity(wish ? 1 : 0)
                .ignoresSafeArea()
                
        }
        .onAppear {
            doAnimation()
        }
    }
    
    func doAnimation() {
        withAnimation(.spring()) {
            wish = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                finishWish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                finishWish = false
                wish = false
            }
        }
    }
}

struct CongreteModalView_Previews: PreviewProvider {
    static var previews: some View {
        CongreteModalView()
    }
}

struct EmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        // Emitter layer
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        // Size and Position
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createEmitterCells() -> [CAEmitterCell] {
        var emitterCells: [CAEmitterCell] = []
        
        for _ in 1...20 {
            let cell = CAEmitterCell()
            
            // Create a random shape for the particle
            let shapeType = Int.random(in: 0...3)
            
            switch shapeType {
            case 0:
                cell.contents = createCircle().cgImage
            case 1:
                cell.contents = createRectangle1().cgImage
            case 2:
                cell.contents = createRectangle2().cgImage
            case 3:
                cell.contents = createRectangle3().cgImage
            default:
                cell.contents = createCircle().cgImage
            }
            
            
            cell.birthRate = 6
            cell.lifetime = 30
            cell.velocity = 200
            cell.velocityRange = 50
            cell.emissionLongitude = .pi * 3.1
            cell.emissionRange = .pi / 4
            cell.scale = 0.1
            cell.scaleRange = 3
            cell.spin = 5
            cell.spinRange = 5
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            let alpha = CGFloat.random(in: 0.5...1)
            cell.color = CGColor(red: red, green: green, blue: blue, alpha: alpha)
            
            emitterCells.append(cell)
        }
        
        return emitterCells
    }
    
    func createCircle() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10))
        let image = renderer.image { context in
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 4, height: 4))
            UIColor.white.setFill()
            circlePath.fill()
        }
        
        return image
    }
    
    func createRectangle1() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10))
        let image = renderer.image { context in
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 10))
            UIColor.white.setFill()
            rectanglePath.fill()
        }
        
        return image
    }
    
    func createRectangle2() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10))
        let image = renderer.image { context in
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 5))
            UIColor.white.setFill()
            rectanglePath.fill()
        }
        
        return image
    }
    
    func createRectangle3() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10))
        let image = renderer.image { context in
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 2))
            UIColor.white.setFill()
            rectanglePath.fill()
        }
        
        return image
    }
    

}
func getRect() -> CGRect {
    return UIScreen.main.bounds
}
