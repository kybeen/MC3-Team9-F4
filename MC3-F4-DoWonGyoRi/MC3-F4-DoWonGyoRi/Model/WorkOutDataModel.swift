//
//  WorkOutDataModel.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/17.
//

import Foundation

class WorkOutDataModel: ObservableObject {
    static let shared = WorkOutDataModel()
    private init() {
        
    }
    
    @Published var isEmitterOn: Bool = false
    @Published var isCongreteModalOn: Bool = false
}
