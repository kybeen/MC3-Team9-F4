//
//  ColorExtension.swift
//  MC3_Tering_Watch Watch App
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation
import SwiftUI

/***
Assets에 추가한 색상을 사용하기 편하도록 extension 구현
Ex) Text("Red Color")
    .foregroundColor(Color.watchColor.red)
 */
extension Color {
    static let watchColor = WatchColor()
}

struct WatchColor {
    let lightGreen = Color("LightGreen")
    let lightBlue = Color("LightBlue")
    let lightBlack = Color("LightBlack")
    let gray = Color("Gray")
    let black = Color("Black")
    let lightRed = Color("LightRed")
    let pink = Color("Pink")
}
