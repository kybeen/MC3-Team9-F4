//
//  EmitterManager.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//

import SwiftUI

/**
 State 처럼 관리해 주기 위해 ObservableObject로 사용
 @Published를 @State처럼 감지할 수 있다.
 */
class EmitterManager: ObservableObject {
    /**
     이것이 싱글톤의 기본 밑바닥 작업이다.
     */
    static let shared = EmitterManager()
    private init() {
        
    }
    
    @Published var isEmitterOn: Bool = false
    @Published var isCongreteModalOn: Bool = false
}
