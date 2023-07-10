//
//  MainView.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        //        GeometryReader { geometry in
        VStack {
            containerView()
            
            VStack(alignment: .leading) {
                Text("어서오세요")
                    .font(.custom("Inter-SemiBold", size: 28))
                Text("용사님")
            }
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
            .padding(.leading, 27)
            
            ScrollView {
                ForEach(0 ..< 100) {_ in
                    Text("안녕")
                        .frame(maxWidth: .infinity)
                }
                .border(.blue)
            }
            .frame(maxWidth: .infinity - 40, minHeight: 200, maxHeight: 700)
            .background(.red)
            
            
        }
        
        .frame(maxHeight: .infinity, alignment: .top)
        //        .safeAreaInset(edge: .bottom, content: {
        //        })
        
        .border(.red)
        //        }
        
        
    }
}

extension MainView {
    private func containerView() -> some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "figure.strengthtraining.functional")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 27)
            }
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 27)
                
            }
        }
    }
    
    private func scrollContainer() -> some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(0 ..< 100) {_ in
                    Text("안녕")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

struct MainView_Provider: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}

struct MeasureSizeModifier: ViewModifier {
    let callback: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            callback(proxy.size)
                        }
                }
            }
    }
    
    
}

extension View {
    func measureSize(_ callback: @escaping (CGSize) -> Void) -> some View {
        modifier(MeasureSizeModifier(callback: callback))
    }
    
    func frameSize(width: CGFloat, height: CGFloat) -> some View {
        self.frame(
            width: convertToCGFloat(point: width, isWidth: true) * UIScreen.main.bounds.width,
            height: convertToCGFloat(point: height, isWidth: false) * UIScreen.main.bounds.height
        )
    }
    
    func convertToCGFloat(point: CGFloat, isWidth: Bool) -> CGFloat {
        let baseSize = isWidth ? 393.0 : 852.0
        
        return point / baseSize
    }
    
    
}
