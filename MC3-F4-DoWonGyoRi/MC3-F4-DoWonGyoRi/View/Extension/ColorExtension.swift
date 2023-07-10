//
//  ColorExtension.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/10.
//
import SwiftUI

extension Color {
    /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .foregroundColor(Color.theme.red)
    /// ```
    static let theme = ColorTheme()
}

struct ColorTheme {
    let white = Color("TennisGreen")
    let gray1 = Color("TennisSkyBlue")
    let gray2 = Color("TennisBlue")
    let gray3 = Color("TennisBlack")
    let gray4 = Color("TennisDarkGray")
    let gray5 = Color("TennisGray")
    let black = Color("TennisWhite")
    let green1 = Color("TennisRedPurple")
    let green2 = Color("TennisPurple")
    let green3 = Color("TennisLightRed")
    let red = Color("TennisRed")
}
